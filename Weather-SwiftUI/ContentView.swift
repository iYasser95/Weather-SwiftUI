//
//  ContentView.swift
//  Weather-SwiftUI
//
//  Created by Apple on 25/12/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNight: Bool = false
    @State private var weather = Weather()
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNight)
                .onAppear(perform: loadData)
            VStack {
                let imageName = isNight ? "moon.stars.fill" : "cloud.sun.fill"
                CityTextView(cityName: "Manama, BH")
                WeatherStatusView(imageName: imageName,
                                  temperature: weather.temp,
                                  max: weather.max,
                                  min: weather.min)
                    
                .padding(.bottom, 40)
                HStack(spacing: 20) {
                    WeatherDayView(title: "Feels Like",
                                   description: "\(weather.feels)°")
                    
                    WeatherDayView(title: "Humidity",
                                   description: "\(weather.humidity)%")
                    
                    WeatherDayView(title: "Pressure",
                                   description: "\(weather.pressure) hPa")
                    
                }
                Spacer()
                
                Button {
                    isNight.toggle()
                } label: {
                    WeatherButton(title: "Change Day Time",
                                  textColor: .blue,
                                  backgroundColor: .white)
                }
                
                Spacer()
                
            }
        }
    }
    
    func loadData() {
        guard let url = URL(string: Constant.url) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let object = try? JSONDecoder().decode(WeatherObject.self, from: data) {
                    DispatchQueue.main.async {
                        self.weather.temp = object.main?.temp ?? 0
                        self.weather.feels = object.main?.feelsLike ?? 0
                        self.weather.min = object.main?.tempMin ?? 0
                        self.weather.max = object.main?.tempMax ?? 0
                        self.weather.pressure = object.main?.pressure ?? 0
                        self.weather.humidity = object.main?.humidity ?? 0
                        
                    }
                    return
                }
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Weather {
    var temp: Int = 0
    var feels: Double = 0
    var min: Int = 0
    var max: Int = 0
    var pressure: Int = 0
    var humidity: Int = 0
}


