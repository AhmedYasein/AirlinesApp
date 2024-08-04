//
//  Airlines+PresenterDelegate.swift
//  airlinesApp
//
//  Created by Ahmed Yasein on 01/08/2024.
//

import Foundation
import UIKit

// MARK: - AirlinesVC (PresenterDelegate Extension)

extension AirlinesVC {
    
    /// Navigates to the details screen of the selected airline.
    /// - Parameter airline: The airline to display details for.
    func navigateToAirlineDetails(airline: Airline) {
        let airlineDetailVC = AirlineDetailVC()
        airlineDetailVC.airline = airline
        airlineDetailVC.presenter = AirlineDetailPresenter(view: airlineDetailVC, airline: airline) // Ensure presenter is set
        navigationController?.pushViewController(airlineDetailVC, animated: true) // Push the details view controller onto the navigation stack
    }
    
    /// Displays a loading indicator to the user.
    func showIndicator() {
        self.view.showLoading() // Calls a method to show a loading indicator
    }
    
    /// Hides the loading indicator from the user.
    func hideIndicator() {
        self.view.hideLoading() // Calls a method to hide the loading indicator
    }
    
    /// Updates the table view to reflect successfully fetched data.
    func fetchingDataSuccess() {
        tableView.reloadData() // Reloads the entire table view to display the updated data
    }
    
    /// Shows an error message to the user.
    /// - Parameter error: The error message to display.
    func showError(error: String) {
        print(error) // Prints the error message to the console
    }
}
