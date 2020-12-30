//
//  Client.swift
//  Weather-SwiftUI
//
//  Created by Apple on 26/12/2020.
//

import Foundation
import Network
class Constant {
    static let shared = Constant()
    static let strings = Strings()
    // MARK: - Strings
    struct Strings {
        let defaultCity = "Manama"
        let defaultCountry = "Bahrain"
        let loading = "Fetching Weather data..."
        let noSearchResults = "Sorry, no search results"
        let searchCity = "Search a City"
        let enterCity = "Please Enter City Name"
        let checkConnection = "Please check connection"
        let tryAgain = "Try again"
        let feelsLike = "Feels Like"
        let humidity = "Humidity"
        let pressure = "Pressure"
        let changeCity = "Change City"
        let warningImage = "warning"
        let blueColor = "lightBlue"
    }
    
    
    
    // MARK: - Functions
    func getStatusImage(from string: String, isNight: Bool) -> String {
        // Get weather image depending on the status (rain, cloud, snow, etc..)
        let status = string.lowercased()
        var image: String = ""
        switch status {
        case "rain":
            image = "cloud.rain.fill"
        case "snow":
            image = "cloud.snow.fill"
        case "fog":
            image = "cloud.fog.fill"
        case "clouds":
            image = "cloud.fill"
        default:
            image = isNight ? "moon.stars.fill" : "sun.max.fill"
        }
        
        return image
    }
    
    func getLocal(from time: Int) -> Int {
        // Get 'hour of the day (24)' depending on the selected city.
        let timezone = TimeZone(secondsFromGMT: time)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = timezone
        dateFormatter.timeStyle = .full
        let date = dateFormatter.string(from: Date())
        let dateAsString = date.formattedDate
        dateFormatter.dateFormat = "h:mm a"
        let formattedDate = dateFormatter.date(from: dateAsString)
        dateFormatter.dateFormat = "HH:mm"
        let date24 = dateFormatter.string(from: formattedDate ?? Date())
        let hour = Int(date24.hour) ?? 0
        return hour
    }
}
