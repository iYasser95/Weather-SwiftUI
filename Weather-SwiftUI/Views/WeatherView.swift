//
//  WeatherView.swift
//  Weather-SwiftUI
//
//  Created by Apple on 26/12/2020.
//

import SwiftUI
struct WeatherView: View {
    @Binding var name: String?
    var body: some View {
        Image(systemName: name ?? "")
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 40, height: 40)
    }
}
