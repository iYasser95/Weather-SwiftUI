//
//  LoadingView.swift
//  Weather-SwiftUI
//
//  Created by Apple on 28/12/2020.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, Color("lightBlue")]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 15) {
                ProgressView()
                    .scaleEffect(CGSize(width: 1.5, height: 1.5))
                Text("Fetching Weather data...")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
            }
        }
    }
}
