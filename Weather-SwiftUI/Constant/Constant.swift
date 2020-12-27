//
//  Client.swift
//  Weather-SwiftUI
//
//  Created by Apple on 26/12/2020.
//

import Foundation
class Constant {
    public static var url = "https://api.openweathermap.org/data/2.5/weather?q=Kuwait&appid=0173d4ad7d634420fe2a187a24469a93&units=metric"
    public static func getUrl(for country: String) -> String {
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(country)&appid=0173d4ad7d634420fe2a187a24469a93&units=metric"
        return url
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
