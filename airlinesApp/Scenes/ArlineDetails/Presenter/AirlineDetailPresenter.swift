//
//  AirlineDetailPresenter.swift
//  airlinesApp
//
//  Created by Ahmed Yasein on 03/08/2024.
//

import Foundation
import RealmSwift

// AirlineDetailView.swift
protocol AirlineDetailView: AnyObject {
    func updateFavoriteButton(isFavorite: Bool)
}



class AirlineDetailPresenter {
    private let callManager = CallManager.shared
    private weak var view: AirlineDetailView?
    private var airline: Airline
    private let realm = try! Realm()
    
    init(view: AirlineDetailView, airline: Airline) {
        self.view = view
        self.airline = airline
    }
    
    func viewDidLoad() {
        view?.updateFavoriteButton(isFavorite: airline.isFavorite)
    }
    
    func toggleFavorite() {
        try! realm.write {
            airline.isFavorite.toggle()
            realm.add(airline, update: .modified)
        }
        view?.updateFavoriteButton(isFavorite: airline.isFavorite)
    }
    
    func openWebsite() {
        if let urlString = airline.site, let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    func callAirline() {
        callManager.processForIncomingCall(sender: "Abhainy",
                                                   uuid: UUID())
    }
    
    
}

