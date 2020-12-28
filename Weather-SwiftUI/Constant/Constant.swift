//
//  Client.swift
//  Weather-SwiftUI
//
//  Created by Apple on 26/12/2020.
//

import Foundation
class Constant {
    static let shared = Constant()
     var url = "https://api.openweathermap.org/data/2.5/weather?q=Kuwait&appid=0173d4ad7d634420fe2a187a24469a93&units=metric"
     func getUrl(for country: String) -> String {
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(country)&appid=0173d4ad7d634420fe2a187a24469a93&units=metric"
        return url
    }
    
     func getAllCities() -> CitiesObject {
        let url = Bundle.main.url(forResource: "data", withExtension: "json")!
        do {
            let data = try Data(contentsOf: url)
            if let object = try? JSONDecoder().decode(CitiesObject.self, from: data) {
                return object.filter { !($0.name?.contains(" ") ?? false) && !($0.name?.contains("$") ?? false)}
            }
        }catch {
            print(error)
        }
        
        return CitiesObject()
    }
}
