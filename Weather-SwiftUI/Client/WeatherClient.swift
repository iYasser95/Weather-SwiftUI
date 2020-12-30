//
//  WeatherClient.swift
//  Weather-SwiftUI
//
//  Created by Apple on 30/12/2020.
//

import Foundation
class WeatherClient {
    static let shared = WeatherClient()
    let token = "0173d4ad7d634420fe2a187a24469a93"
    let unit = "metric"
    
    func loadWeatherData(for country: String, completion: @escaping (WeatherObject?, Error?) -> Void) {
        var urlComponent = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather")
        urlComponent?.queryItems = [URLQueryItem(name: "q", value: country),
                                    URLQueryItem(name: "appid", value: token),
                                    URLQueryItem(name: "units", value: unit)]
        
        guard let url = urlComponent?.url else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }

            DispatchQueue.global(qos: .background).async {
                let responseObject = try? WeatherObject(data: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            }
        }.resume()
    }
    
    func getAllCities(completion: @escaping (CitiesObject?, Error?) -> Void) {
        let url = Bundle.main.url(forResource: "data", withExtension: "json")!
        guard let data = try? Data(contentsOf: url) else {
            DispatchQueue.main.async {
                completion(nil, nil)
            }
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            let object = try? JSONDecoder().decode(CitiesObject.self, from: data)
            DispatchQueue.main.async {
                completion(object, nil)
            }
        }
        
    }
}
