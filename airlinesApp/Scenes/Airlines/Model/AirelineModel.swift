//
//  AirelineModel.swift
//  airlinesApp
//
//  Created by Ahmed Yasein on 01/08/2024.
//

import RealmSwift

class Airline: Object, Codable {
    @objc dynamic var site: String?
    @objc dynamic var code: String?
    @objc dynamic var alliance: String?
    @objc dynamic var phone: String?
    @objc dynamic var name: String?
    @objc dynamic var usName: String?
    @objc dynamic var clazz: String?
    @objc dynamic var defaultName: String?
    @objc dynamic var logoURL: String?
    @objc dynamic var isFavorite: Bool = false

    override class func primaryKey() -> String? {
        return "code"
    }

    enum CodingKeys: String, CodingKey {
        case site
        case code
        case alliance
        case phone
        case name
        case usName
        case clazz = "__clazz"
        case defaultName
        case logoURL
        case isFavorite
    }

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
