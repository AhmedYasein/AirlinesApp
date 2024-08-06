//
//  AirlineDetailPresenter.swift
//  airlinesApp
//
//  Created by Ahmed Yasein on 03/08/2024.
//

import Foundation
import RealmSwift

// MARK: - AirlineDetailView Protocol
/// Defines methods for updating the airline detail view.
protocol AirlineDetailView: AnyObject {
    func updateFavoriteButton(isFavorite: Bool)
}

// MARK: - AirlineDetailPresenter
/// Manages the business logic for the airline detail view.
class AirlineDetailPresenter: AirlineDetailActionHandler {
    
    // MARK: - Properties
    private let callManager = CallManager.shared // Manages call actions
    private weak var view: AirlineDetailView? // Reference to the view
    private var airline: Airline // The airline data model
    private let realm = try! Realm() // Realm instance for local data
    
    // MARK: - Initializer
    init(view: AirlineDetailView, airline: Airline) {
        self.view = view
        self.airline = airline
    }
    
    // MARK: - Public Methods
    
    /// Initializes the view with the current favorite status.
    func viewDidLoad() {
        view?.updateFavoriteButton(isFavorite: airline.isFavorite)
    }
    
    /// Toggles the favorite status and updates the view.
    func toggleFavorite() {
        do {
            try realm.write {
                airline.isFavorite.toggle()
                realm.add(airline, update: .modified)
            }
            view?.updateFavoriteButton(isFavorite: airline.isFavorite)
        } catch {
            print("Error updating favorite status: \(error.localizedDescription)")
        }
    }
    
    /// Opens the airline's website.
    func openWebsite() {
        if let urlString = airline.site, let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        } else {
            print("Invalid URL: \(airline.site ?? "No URL provided")")
        }
    }
    
    /// Initiates a call to the airline.
    func callAirline() {
        guard let airlinePhone = airline.phone else {
            // Handle case where airline phone is nil
            print("Airline phone number is nil")
            return
        }
        // callManager.reportIncomingCall(uuid: UUID(), handle: airlinePhone)
        callManager.startCall(handle: airlinePhone)
    }

}
