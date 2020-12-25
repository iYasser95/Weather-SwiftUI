//
//  WeatherDayView.swift
//  Weather-SwiftUI
//
//  Created by Apple on 26/12/2020.
//

import SwiftUI
struct WeatherDayView: View {
    var day: String
    var image: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 20) {
            Text(day)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            Image(systemName: image)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
            Text("\(temperature)°")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
            
        }
    }
}
