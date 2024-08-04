//
//  Networking.swift
//  airlinesApp
//
//  Created by Ahmed Yasein on 01/08/2024.
//

import Foundation
import Alamofire


// Define the protocol for airline services
protocol AirlineService {
    func fetchAirlines(completion: @escaping (Result<[Airline], Error>) -> Void)
}

// Implement the APICaller class
class AirlinesInteractor: AirlineService {
    
    
    func fetchAirlines(completion: @escaping (Result<[Airline], Error>) -> Void) {
        let url = "https://www.kayak.com/h/mobileapis/directory/airlines"
        
        // Make the network request
        AF.request(url, method: .get).responseDecodable(of: [Airline].self) { response in
            switch response.result {
            case .success(let airlines):
                // Successfully decoded the data into the Airline model
                completion(.success(airlines))
            case .failure(let error):
                // Handle JSON decoding or network request error
                completion(.failure(error))
            }
        }
    }
}
