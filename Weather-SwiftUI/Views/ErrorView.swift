//
//  ErrorView.swift
//  Weather-SwiftUI
//
//  Created by Apple on 28/12/2020.
//

import SwiftUI
struct ErrorView: View {
    var image: String
    var text: String
    var body: some View {
       return VStack(spacing: 20) {
            Image(image)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100, alignment: .center)
                .padding(.top, 200)
            Text(text)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.gray)
            Spacer()
        }
    }
}
