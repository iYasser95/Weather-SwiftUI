//
//  WeatherStatusView.swift
//  Weather-SwiftUI
//
//  Created by Apple on 26/12/2020.
//

import SwiftUI

struct WeatherStatusView: View {
    var imageName: String
    var temperature: Double
    var max: Double
    var min: Double
    var body: some View {
        let temp = String(format: "%.2f", temperature)
        let maxTemp = String(format: "%.2f", max)
        let minTemp = String(format: "%.2f", min)
        VStack(spacing: 8) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 180, height: 180)
            Text(temp)
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
            HStack {
                Text("H:\(maxTemp)")
                    .foregroundColor(.white)
                Text("L:\(minTemp)")
                    .foregroundColor(.white)
            }
            
        }
    }
}
