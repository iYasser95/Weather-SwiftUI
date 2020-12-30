//
//  Row.swift
//  Weather-SwiftUI
//
//  Created by Apple on 27/12/2020.
//

import SwiftUI
struct Row: View {
    @Binding var showSelf: Bool
    @Binding var selectedCity: String
    @State private var countryList = CitiesObject()
    @Binding var searchText: String
    @Binding var isLoading: Bool
    var body: some View {
        let filteredList = countryList.filter { $0.name?.lowercased().contains(searchText.lowercased()) ?? false}
        return List(filteredList) { country in
            Button(action: {
                self.isLoading = true
                self.showSelf = false
                self.selectedCity = country.name ?? ""
            }) {
                
                VStack() {
                    HStack() {
                        Text(country.name ?? "")
                            .bold()
                            .font(.system(size: 17.0))
                        Spacer()
                    }
                }
            }
            .foregroundColor(.gray)
            .padding(0)
       }.onAppear(perform: getAllCities)
    }
    
    
    func getAllCities() {
        WeatherClient.shared.getAllCities { (object, error) in
            guard let list = object, error == nil else {
                return
            }
            
            self.countryList = list.filter { !($0.name?.contains(" ") ?? false) && !($0.name?.contains("$") ?? false)}
        }
    }
}
