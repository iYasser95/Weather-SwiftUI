// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weatherObject = try WeatherObject(json)

import Foundation

// MARK: - WeatherObject
struct WeatherObject: Codable {
    let weather: Weather?
    let country: Country?
    let timezone: Int?
    
    enum CodingKeys: String, CodingKey {
        case weather = "main"
        case country = "sys"
        case timezone
    }
}

// MARK: WeatherObject convenience initializers and mutators

extension WeatherObject {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(WeatherObject.self, from: data)
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

    func with(main: Weather?? = nil) -> WeatherObject {
        return WeatherObject(weather: weather ?? self.weather,
                             country: country ?? self.country,
                             timezone: timezone ?? self.timezone)
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Main
struct Weather: Codable {
    let temp: Double?
    let feelsLike: Double?
    let tempMin, tempMax, pressure, humidity: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: Main convenience initializers and mutators

extension Weather {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Weather.self, from: data)
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
        temp: Double?? = nil,
        feelsLike: Double?? = nil,
        tempMin: Double?? = nil,
        tempMax: Double?? = nil,
        pressure: Double?? = nil,
        humidity: Double?? = nil
    ) -> Weather {
        return Weather(
            temp: temp ?? self.temp,
            feelsLike: feelsLike ?? self.feelsLike,
            tempMin: tempMin ?? self.tempMin,
            tempMax: tempMax ?? self.tempMax,
            pressure: pressure ?? self.pressure,
            humidity: humidity ?? self.humidity
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}


struct Country: Codable {
    let type, id: Int?
    let sunrise, sunset: Int?
    let country: String?
}

// MARK: Main convenience initializers and mutators

extension Country {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Country.self, from: data)
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
        type: Int?? = nil,
        id: Int?? = nil,
        sunrise: Int?? = nil,
        sunset: Int?? = nil,
        country: String?? = nil
    ) -> Country {
        return Country(
            type: type ?? self.type,
            id: id ?? self.id,
            sunrise: sunrise ?? self.sunrise,
            sunset: sunset ?? self.sunset,
            country: country ?? self.country
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}



// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
