//
//  Airlines+PresenterDelegate.swift
//  airlinesApp
//
//  Created by Ahmed Yasein on 01/08/2024.
//

import Foundation
import UIKit
extension AirlinesVC {
    
    func navigateToAirlineDetails(airline: Airline) {
        let airlineDetailVC = AirlineDetailVC()
        airlineDetailVC.airline = airline
        airlineDetailVC.presenter = AirlineDetailPresenter(view: airlineDetailVC, airline: airline) // Ensure presenter is set
        navigationController?.pushViewController(airlineDetailVC, animated: true)
    }


    
    func showIndicator() {
        self.view.showLoading()

    }
    
    func hideIndicator() {
        self.view.hideLoading()
    }
    
    func fetchingDataSuccess() {
        tableView.reloadData()

    }
    
    func showError(error: String) {
        print(error)

    }
    
    
}
