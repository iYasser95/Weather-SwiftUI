//
//  BackgroundView.swift
//  Weather-SwiftUI
//
//  Created by Apple on 26/12/2020.
//

import SwiftUI
struct BackgroundView: View {
    
    @Binding var isNight: Bool     
    var body: some View {
        let topColor: Color = isNight ? .black : .blue
        let bottomColor: Color = isNight ? .gray : Color("lightBlue")
        LinearGradient(gradient: Gradient(colors: [topColor, bottomColor]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}
