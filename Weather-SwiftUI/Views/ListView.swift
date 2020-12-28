//
//  ListView.swift
//  Weather-SwiftUI
//
//  Created by Apple on 28/12/2020.
//

import SwiftUI
struct ListView: View {
    @Binding var showDetail: Bool
    @Binding var selectedCountry: String
    @State private var country: CitiesObject = Constant.shared.getAllCities()
    @State var searchText: String = ""
    @State var isEmpty: Bool = true
    @Binding var isLoading: Bool
    var body: some View {
        VStack {
            TextField("Please Enter City Name", text: $searchText)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding([.leading, .trailing], 15)
            HStack {
                if searchText.isEmpty || country.filter { ($0.name?.contains(searchText) ?? false)}.isEmpty {
                    ErrorView(image: "warning", text: "Sorry, no search results")
                        .navigationTitle("Search a City")
                }else {
                    Row(showSelf: $showDetail, selectedCountry: $selectedCountry, searchText: $searchText, isLoading: $isLoading)
                            .navigationTitle("Choose a City")
                }

            }.background(Color.clear)
        }

            
    }
    
    func checkSearch() {
        self.isEmpty = searchText.isEmpty
    }
}
