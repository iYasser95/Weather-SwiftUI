//
//  CitiesObject.swift
//  Weather-SwiftUI
//
//  Created by Apple on 27/12/2020.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let citiesObject = try CitiesObject(json)

import Foundation

// MARK: - CitiesObjectElement
struct CitiesObjectElement: Codable, Identifiable {
    let country: String?
    let id: Int?
    let name, subcountry: String?
    
    enum CodingKeys: String, CodingKey {
        case country,name,subcountry
        case id = "geonameid"
    }
}

// MARK: CitiesObjectElement convenience initializers and mutators

extension CitiesObjectElement {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CitiesObjectElement.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        country: String?? = nil,
        id: Int?? = nil,
        name: String?? = nil,
        subcountry: String?? = nil
    ) -> CitiesObjectElement {
        return CitiesObjectElement(
            country: country ?? self.country,
            id: id ?? self.id,
            name: name ?? self.name,
            subcountry: subcountry ?? self.subcountry
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

typealias CitiesObject = [CitiesObjectElement]

extension Array where Element == CitiesObject.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CitiesObject.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
