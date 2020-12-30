//
//  ListView.swift
//  Weather-SwiftUI
//
//  Created by Apple on 28/12/2020.
//

import SwiftUI
struct ListView: View {
    @Binding var showDetail: Bool
    @Binding var selectedCity: String
    @State private var country = CitiesObject()
    @State var searchText: String = ""
    @State var isEmpty: Bool = true
    @Binding var isLoading: Bool
    var body: some View {
        VStack {
            TextField(Constant.strings.enterCity, text: $searchText)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding([.leading, .trailing], 15)
            HStack {
                if searchText.isEmpty || country.filter { ($0.name?.contains(searchText) ?? false)}.isEmpty {
                    ErrorView(image: Constant.strings.warningImage, text: Constant.strings.noSearchResults)
                        .navigationTitle(Constant.strings.searchCity)
                }else {
                    Row(showSelf: $showDetail, selectedCity: $selectedCity, searchText: $searchText, isLoading: $isLoading)
                            .navigationTitle(Constant.strings.searchCity)
                }

            }.background(Color.clear)
        }.onAppear(perform: getAllCities)            
    }
    
    func getAllCities() {
        WeatherClient.shared.getAllCities { (object, error) in
            guard let list = object, error == nil else {
                return
            }
            
            self.country = list.filter { !($0.name?.contains(" ") ?? false) && !($0.name?.contains("$") ?? false)}
        }
    }
    
    func checkSearch() {
        self.isEmpty = searchText.isEmpty
    }
}
