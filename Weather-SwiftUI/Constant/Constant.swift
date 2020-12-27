//
//  Client.swift
//  Weather-SwiftUI
//
//  Created by Apple on 26/12/2020.
//

import Foundation
class Constant {
    public static var url = "https://api.openweathermap.org/data/2.5/weather?q=Kuwait&appid=0173d4ad7d634420fe2a187a24469a93&units=metric"
    public static func getUrl(for country: Countries) -> String {
        let city = country.rawValue
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=0173d4ad7d634420fe2a187a24469a93&units=metric"
        return url
    }
    
    
    public static func getCountries() -> [CountriesList] {
        let types = Countries.allCases.filter { $0 != .none}
        var list: [CountriesList] = []
        
        for type in types {
            list.append(CountriesList(id: UUID().uuidString, name: type.name, city: type.city))
        }
        
        return list
    }
    
    enum Countries: String, CaseIterable {
        case Bahrain = "Manama"
        case SaudiArabia = "Riyadh"
        case Kuwait = "Kuwait"
        case Egypt = "Cairo"
        case Iraq = "Baghdad"
        case Jordan = "Amman"
        case Algeria = "Algiers"
        case Morocco = "Casablanca"
        case UAE = "Dubai"
        case Lebanon = "Beirut"
        case Tunisia = "Tunis"
        case Qatar = "Doha"
        case none = ""
        
        
        var name: String {
            let title: String
            switch self {
            case .SaudiArabia:
                title = "Saudi Arabia"
            case .UAE:
                title = "United Arab Emirates"
            default:
                title = "\(self)"
            }

            return title
        }
        
        var city: String {
            let city: String
            switch self {
            default:
                city = self.rawValue
            }
            
            return city
        }
        
        
        var cityName: String {
            let cityName: String
            switch self {
            case .Bahrain:
                cityName = "Manama, BH"
            case .SaudiArabia:
                cityName = "Riyadh, SA"
            case .Kuwait:
                cityName = "Kuwait, KW"
            case .Egypt:
                cityName = "Cairo, EGY"
            case .Iraq:
                cityName = "Baghdad, IRQ"
            case .Jordan:
                cityName = "Amman, JOR"
            case .Algeria:
                cityName = "Algiers, DZA"
            case .Morocco:
                cityName = "Casablanca, MAR"
            case .UAE:
                cityName = "Dubai, UAE"
            case .Lebanon:
                cityName = "Beirut, LBN"
            case .Tunisia:
                cityName = "Tunisia, TUN"
            case .Qatar:
                cityName = "Qatar, QAT"
            case .none:
                cityName = ""
            }
            
            return cityName
        }
        
    }
}

struct CountriesList: Identifiable {
    var id: String
    var name: String
    var city: String
}


struct Weather {
    var temp: Double = 0
    var feels: Double = 0
    var min: Double = 0
    var max: Double = 0
    var pressure: Double = 0
    var humidity: Double = 0
}
