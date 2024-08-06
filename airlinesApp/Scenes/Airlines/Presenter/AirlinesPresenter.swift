import Foundation
import RealmSwift

// MARK: - Protocols

/// Methods for view to handle data states and interactions.
protocol AirlinesView: AnyObject {
    func showIndicator()
    func hideIndicator()
    func fetchingDataSuccess()
    func showError(error: String)
    func updateCell(at index: Int)
    func navigateToAirlineDetails(airline: Airline)
}

/// Methods for configuring an airline cell in the view.
protocol AirlineCellView {
    func displayName(name: String)
    func displaylogo(logo: String)
    func setFavorite(isFavorite: Bool)
}

// MARK: - Presenter

/// Manages the presentation logic for airlines list.
class AirlinesPresenter {
    private var allAirlines = [Airline]()
    private var favoriteAirlines = [Airline]()
    private weak var view: AirlinesView?
    private let interactor = AirlinesInteractor()
    private let realm = try! Realm()

    // MARK: - Initialization

    /// Initializes the presenter with a view.
    init(view: AirlinesView) {
        self.view = view
    }

    // MARK: - Public Methods

    /// Loads airlines data, either from Realm or API.
    func load() {
        loadAirlinesFromRealm() // Load data from Realm
        if allAirlines.isEmpty { // Check if data is missing
            getAirlines() // Fetch from API
        } else {
            view?.fetchingDataSuccess() // Notify view if data is available
        }
    }

    /// Called when the view is loaded.
    func viewDidLoad() {
        load() // Trigger data load
    }

    /// Returns the number of airlines.
    func getAirlinesCount() -> Int {
        return allAirlines.count
    }

    /// Configures the cell with airline data for display.
    func configure(cell: AirlineCellView, for index: Int) {
           let airline = allAirlines[index]
           let baseUrl = "https://www.kayak.com/"
           let airlineLogo = airline.logoURL ?? ""
           let fullLogoPath = baseUrl + airlineLogo
           cell.displayName(name: airline.name ?? "")
           cell.displaylogo(logo: fullLogoPath )
           cell.setFavorite(isFavorite: airline.isFavorite)
       }

    /// Toggles between displaying all airlines and only favorite ones.
    func toggleAirlineList(isFavorites: Bool) {
        if isFavorites {
            // Show only favorite airlines
            allAirlines = Array(realm.objects(Airline.self).filter("isFavorite == true"))
        } else {
            // Show all airlines, regardless of favorite status
            allAirlines = Array(realm.objects(Airline.self))
        }
        view?.fetchingDataSuccess() // Notify view of data update
    }


    /// Marks an airline as favorite or not, based on its current state.
    func markAsFavorite(at index: Int) {
        let airline = allAirlines[index]
        try! realm.write {
            airline.isFavorite.toggle() // Toggle favorite status
        }
        view?.updateCell(at: index) // Notify view of update
    }

    /// Handles the selection of a row in the list.
    func didSelectRow(at index: Int) {
        let airline = allAirlines[index]
        view?.navigateToAirlineDetails(airline: airline) // Navigate to details view
    }

    /// Updates an existing airline with new data.
    func updateAirline(_ updatedAirline: Airline) {
        if let index = allAirlines.firstIndex(where: { $0.code == updatedAirline.code }) {
            try! realm.write {
                realm.add(updatedAirline, update: .modified) // Save updated data
            }
            allAirlines[index] = updatedAirline
            view?.updateCell(at: index) // Notify view of update
        }
    }

    // MARK: - Private Methods

    /// Loads airlines from the Realm database.
    private func loadAirlinesFromRealm() {
        let airlines = realm.objects(Airline.self)
        allAirlines = Array(airlines)
        favoriteAirlines = allAirlines.filter { $0.isFavorite }
    }

    /// Fetches airlines data from the API and handles success or failure.
    private func getAirlines() {
        view?.showIndicator() // Show loading indicator
        interactor.fetchAirlines { [weak self] result in
            self?.view?.hideIndicator() // Hide loading indicator
            guard let self = self else { return }
            switch result {
            case .success(let airlines):
                self.saveAirlinesToRealm(airlines)
                self.allAirlines = airlines
                self.view?.fetchingDataSuccess() // Notify view of success
                
            case .failure(let error):
                self.view?.showError(error: error.localizedDescription) // Show error
            }
        }
    }

    /// Saves a list of airlines to Realm.
    private func saveAirlinesToRealm(_ airlines: [Airline]) {
        try! realm.write {
            realm.add(airlines, update: .modified) // Save to Realm
        }
    }
}
