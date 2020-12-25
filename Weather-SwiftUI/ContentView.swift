//
//  ContentView.swift
//  Weather-SwiftUI
//
//  Created by Apple on 25/12/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNight: Bool = false
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNight)
            VStack {
                let statusImage = isNight ? "moon.stars.fill" : "cloud.sun.fill"
                let temperature = isNight ? 65 : 76
                CityTextView(cityName: "Cupertino, CA")
                WeatherStatusView(imageName: statusImage,
                                  temperature: temperature)
                    
                .padding(.bottom, 40)
                HStack(spacing: 20) {
                    WeatherDayView(day: "TUE",
                                   image: "cloud.sun.fill",
                                   temperature: 76)
                    
                    WeatherDayView(day: "WED",
                                   image: "sun.max.fill",
                                   temperature: 88)
                    
                    WeatherDayView(day: "THU",
                                   image: "wind",
                                   temperature: 55)
                    
                    WeatherDayView(day: "FRI",
                                   image: "sunset.fill",
                                   temperature: 66)
                    
                    WeatherDayView(day: "SAT",
                                   image: "moon.stars.fill",
                                   temperature: 60)
                    
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}












