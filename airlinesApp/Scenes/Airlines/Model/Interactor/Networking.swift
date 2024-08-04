//
//  Networking.swift
//  airlinesApp
//
//  Created by Ahmed Yasein on 01/08/2024.
//

import Foundation
import Alamofire

// MARK: - AirlineService Protocol

/// Defines the methods required for fetching airline data.
protocol AirlineService {
    /// Fetches a list of airlines.
    /// - Parameter completion: A closure to be executed once the request completes. It returns a `Result` containing either an array of `Airline` objects or an `Error`.
    func fetchAirlines(completion: @escaping (Result<[Airline], Error>) -> Void)
}

// MARK: - AirlinesInteractor Class

/// Implements the `AirlineService` protocol to fetch airline data from an API.
class AirlinesInteractor: AirlineService {
    
    /// Fetches airline data from the API.
    /// - Parameter completion: A closure to be executed once the network request completes. It returns a `Result` containing either an array of `Airline` objects or an `Error`.
    func fetchAirlines(completion: @escaping (Result<[Airline], Error>) -> Void) {
        let url = "https://www.kayak.com/h/mobileapis/directory/airlines"
        
        // Initiates the network request to fetch airline data.
        AF.request(url, method: .get).responseDecodable(of: [Airline].self) { response in
            switch response.result {
            case .success(let airlines):
                // On success, returns the decoded array of `Airline` objects.
                completion(.success(airlines))
            case .failure(let error):
                // On failure, returns the encountered error.
                completion(.failure(error))
            }
        }
    }
}
