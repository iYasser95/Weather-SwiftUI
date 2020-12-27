//
//  Row.swift
//  Weather-SwiftUI
//
//  Created by Apple on 27/12/2020.
//

import SwiftUI
struct Row: View {
    @Binding var showSelf: Bool
    @Binding var selectedCountry: String
    @State private var countryList = CitiesObject()
    @Binding var searchText: String
    var body: some View {
        let filteredList = countryList.filter { $0.name?.lowercased().contains(searchText.lowercased()) ?? false}
        return List(filteredList) { country in
            Button(action: {
                self.showSelf = false
                self.selectedCountry = country.name ?? ""
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
        let url = Bundle.main.url(forResource: "data", withExtension: "json")!
        do {
            let data = try Data(contentsOf: url)
            if let object = try? JSONDecoder().decode(CitiesObject.self, from: data) {
                self.countryList = object.filter { !($0.name?.contains(" ") ?? false) && !($0.name?.contains("$") ?? false)}
            }
        }catch {
            print(error)
        }
    }
}
