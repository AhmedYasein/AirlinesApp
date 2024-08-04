import Foundation
import RealmSwift

protocol AirlinesView: AnyObject {
    func showIndicator()
    func hideIndicator()
    func fetchingDataSuccess()
    func showError(error: String)
    func updateCell(at index: Int)
    func navigateToAirlineDetails(airline: Airline)
}

protocol AirlineCellView {
    func displayName(name: String)
    func displaylogo(logo: String)
    func setFavorite(isFavorite: Bool)
}


class AirlinesPresenter {
    private var allAirlines = [Airline]()
    private var favoriteAirlines = [Airline]()
    private weak var view: AirlinesView?
    private let interactor = AirlinesInteractor()
    private let realm = try! Realm()

    init(view: AirlinesView) {
        self.view = view
    }

    func load() {
        loadAirlinesFromRealm() // Load data from Realm
        if allAirlines.isEmpty { // Check if Realm is empty
            getAirlines() // Fetch from API if Realm is empty
        } else {
            view?.fetchingDataSuccess() // If data is available, just update the view
        }
    }
    
    
    func viewDidLoad() {
        load()
    }

    private func loadAirlinesFromRealm() {
        let airlines = realm.objects(Airline.self)
        allAirlines = Array(airlines)
        favoriteAirlines = allAirlines.filter { $0.isFavorite }
    }

    func getAirlines() {
        view?.showIndicator()
        interactor.fetchAirlines { [weak self] result in
            self?.view?.hideIndicator()
            guard let self = self else { return }
            switch result {
            case .success(let airlines):
                self.saveAirlinesToRealm(airlines)
                self.allAirlines = airlines
                self.view?.fetchingDataSuccess()
                
            case .failure(let error):
                self.view?.showError(error: error.localizedDescription)
            }
        }
    }

    private func saveAirlinesToRealm(_ airlines: [Airline]) {
        try! realm.write {
            realm.add(airlines, update: .modified)
        }
    }

    func toggleAirlineList(isFavorites: Bool) {
        if isFavorites {
            allAirlines = Array(realm.objects(Airline.self).filter("isFavorite == true"))
        } else {
            allAirlines = Array(realm.objects(Airline.self))
        }
        view?.fetchingDataSuccess()
    }

    func getAirlinesCount() -> Int {
        return allAirlines.count
    }

    func configure(cell: AirlineCellView, for index: Int) {
        let airline = allAirlines[index]
        cell.displayName(name: airline.name ?? "")
        cell.displaylogo(logo: "https://www.kayak.com/" + (airline.logoURL ?? ""))
        cell.setFavorite(isFavorite: airline.isFavorite)
    }

    func markAsFavorite(at index: Int) {
        let airline = allAirlines[index]
        try! realm.write {
            airline.isFavorite.toggle()
        }
        view?.updateCell(at: index)
    }
    
    func didSelectRow(at index: Int) {
        let airline = allAirlines[index]
        view?.navigateToAirlineDetails(airline: airline)
    }
    
    func updateAirline(_ updatedAirline: Airline) {
           if let index = allAirlines.firstIndex(where: { $0.code == updatedAirline.code }) {
               try! realm.write {
                   realm.add(updatedAirline, update: .modified)
               }
               allAirlines[index] = updatedAirline
               view?.updateCell(at: index)
           }
       }
}
