//
//  Row.swift
//  Weather-SwiftUI
//
//  Created by Apple on 27/12/2020.
//

import SwiftUI
struct Row: View {
    let countryList: [CountriesList] = Constant.getCountries()
    @Binding var showSelf: Bool
    @Binding var selectedCountry: Constant.Countries
    var body: some View {
       return List(countryList) { country in
            Button(action: {
                self.showSelf = false
                self.selectedCountry = Constant.Countries(rawValue: country.city) ?? .none
            }) {
                VStack() {
                    HStack() {
                        Text(country.name)
                            .bold()
                            .font(.system(size: 17.0))
                        Spacer()
                    }
                }
            }
            .foregroundColor(.gray)
            .padding(0)
        }
    }
}
