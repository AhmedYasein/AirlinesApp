//
//  AirelineModel.swift
//  airlinesApp
//
//  Created by Ahmed Yasein on 01/08/2024.
//

import RealmSwift

// MARK: - Airline Model

/// Represents an airline object in the app, conforming to `RealmSwift.Object` for persistence and `Codable` for JSON decoding.
class Airline: Object, Codable {
    
    // MARK: - Properties
    
    @objc dynamic var site: String?          // The website of the airline.
    @objc dynamic var code: String?          // The unique code for the airline.
    @objc dynamic var alliance: String?      // The airline alliance the airline belongs to.
    @objc dynamic var phone: String?         // The contact phone number of the airline.
    @objc dynamic var name: String?          // The name of the airline.
    @objc dynamic var usName: String?        // The US name of the airline.
    @objc dynamic var clazz: String?         // The class type for the airline (e.g., business, economy).
    @objc dynamic var defaultName: String?   // The default name for the airline.
    @objc dynamic var logoURL: String?       // The URL of the airline's logo.
    @objc dynamic var isFavorite: Bool = false // Indicates whether the airline is marked as a favorite.

    // MARK: - Realm Configuration
    
    /// Specifies the primary key for the `Airline` object, which is used to uniquely identify instances in Realm.
    override class func primaryKey() -> String? {
        return "code"
    }

    // MARK: - Codable
    
    /// Enum to define the coding keys for the `Airline` properties.
    enum CodingKeys: String, CodingKey {
        case site
        case code
        case alliance
        case phone
        case name
        case usName
        case clazz = "__clazz"          // Special case for a property with a name that might conflict.
        case defaultName
        case logoURL
        case isFavorite
    }

    /// Initializes an `Airline` instance from a decoder.
    /// - Parameter decoder: A `Decoder` to decode the JSON data into the `Airline` properties.
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        site = try container.decodeIfPresent(String.self, forKey: .site)
        code = try container.decodeIfPresent(String.self, forKey: .code)
        alliance = try container.decodeIfPresent(String.self, forKey: .alliance)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        usName = try container.decodeIfPresent(String.self, forKey: .usName)
        clazz = try container.decodeIfPresent(String.self, forKey: .clazz)
        defaultName = try container.decodeIfPresent(String.self, forKey: .defaultName)
        logoURL = try container.decodeIfPresent(String.self, forKey: .logoURL)
        isFavorite = try container.decodeIfPresent(Bool.self, forKey: .isFavorite) ?? false
    }
}
