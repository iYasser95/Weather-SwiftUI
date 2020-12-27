//
//  ContentView.swift
//  Weather-SwiftUI
//
//  Created by Apple on 25/12/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var showDetail = false
    @State private var isNight: Bool = false
    @State private var weather = Weather()
    @State private var selectedCountry: String = "Manama"
    @State private var countries = CitiesObject()
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView(isNight: $isNight)
                    .onAppear(perform: loadData)
                    .onAppear(perform: getTime)
                VStack {
                    let imageName = isNight ? "moon.stars.fill" : "cloud.sun.fill"
                    CityTextView(cityName: selectedCountry)
                    WeatherStatusView(imageName: imageName,
                                      temperature: weather.temp,
                                      max: weather.max,
                                      min: weather.min)
                        
                    .padding(.bottom, 40)
                    HStack(spacing: 20) {
                        WeatherDayView(title: "Feels Like",
                                       description: "\(weather.feels)°")
                        
                        WeatherDayView(title: "Humidity",
                                       description: "\(weather.humidity)%")
                        
                        WeatherDayView(title: "Pressure",
                                       description: "\(weather.pressure) hPa")
                        
                    }
                    Spacer()
                    
                    NavigationLink(destination: ListView(showDetail: $showDetail, selectedCountry: $selectedCountry), isActive: $showDetail) {
                        let textColor: Color = isNight ? .black : .blue
                        WeatherButton(title: "Change Country",
                                      textColor: textColor,
                                      backgroundColor: .white)
                    }
                    
                    Spacer()
                    
                }
            }
        }

    }
    
    func getTime() {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5...18:
            self.isNight = false
        default:
            self.isNight = true
        }
        
    }
    
    func loadData() {
        guard let url = URL(string: Constant.getUrl(for: selectedCountry)) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let object = try? JSONDecoder().decode(WeatherObject.self, from: data) {
                    DispatchQueue.main.async {
                        self.weather.temp = object.main?.temp ?? 0
                        self.weather.feels = object.main?.feelsLike ?? 0
                        self.weather.min = object.main?.tempMin ?? 0
                        self.weather.max = object.main?.tempMax ?? 0
                        self.weather.pressure = object.main?.pressure ?? 0
                        self.weather.humidity = object.main?.humidity ?? 0
                        
                    }
                    return
                }
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ListView: View {
    @Binding var showDetail: Bool
    @Binding var selectedCountry: String
    @State private var country: CitiesObject = CitiesObject()
    @State var searchText: String = ""
    @State var isEmpty: Bool = true
    var body: some View {
        VStack {
            TextField("Please Enter City Name", text: $searchText)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding([.leading, .trailing], 15)
            HStack {
                    Row(showSelf: $showDetail, selectedCountry: $selectedCountry, searchText: $searchText)
                        .navigationTitle("Choose a Country")
            }.background(Color.clear)
        }

            
    }
    
    func checkSearch() {
        self.isEmpty = searchText.isEmpty
    }
}

extension String {
    var removeWhiteSpace: String {
       return self.replacingOccurrences(of: " ", with: "")
    }
}






