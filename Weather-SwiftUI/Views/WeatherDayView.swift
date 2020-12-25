//
//  WeatherDayView.swift
//  Weather-SwiftUI
//
//  Created by Apple on 26/12/2020.
//

import SwiftUI
struct WeatherDayView: View {
    var title: String
    var description: String
    
    var body: some View {
        VStack(spacing: 2) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            Text(description)
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
            
        }
    }
}
