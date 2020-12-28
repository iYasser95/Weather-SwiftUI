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
    @State private var weather: Weather?
    @State private var selectedCountry: String = "Manama"
    @State private var countries = CitiesObject()
    @State private var country: Country?
    @State private var countryName: String = "Bahrain"
    @State private var timezone: Int = 0
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView(isNight: $isNight)
                    .onAppear(perform: loadData)
                VStack {
                    let imageName = isNight ? "moon.stars.fill" : "cloud.sun.fill"
                    CityTextView(cityName: selectedCountry)
                    Text(countryName)
                        .padding(.top, -25)
                        .font(.system(size: 18, weight: .medium, design: .default))
                        .foregroundColor(.white)
                    WeatherStatusView(imageName: imageName,
                                      temperature: weather?.temp ?? 0,
                                      max: weather?.tempMax ?? 0,
                                      min: weather?.tempMin ?? 0)
                        
                    .padding(.bottom, 40)
                    HStack(spacing: 20) {
                        WeatherDayView(title: "Feels Like",
                                       description: "\(weather?.feelsLike ?? 0)°")
                        
                        WeatherDayView(title: "Humidity",
                                       description: "\(weather?.humidity ?? 0)%")
                        
                        WeatherDayView(title: "Pressure",
                                       description: "\(weather?.pressure ?? 0) hPa")
                        
                    }
                    Spacer()
                    
                    NavigationLink(destination: ListView(showDetail: $showDetail, selectedCountry: $selectedCountry), isActive: $showDetail) {
                        let textColor: Color = isNight ? .black : .blue
                        WeatherButton(title: "Change City",
                                      textColor: textColor,
                                      backgroundColor: .white)
                    }
                    
                    Spacer()
                    
                }
            }
        }

    }
    
    func loadData() {
        guard let url = URL(string: Constant.getUrl(for: selectedCountry)) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let object = try? JSONDecoder().decode(WeatherObject.self, from: data) {
                    DispatchQueue.main.async {
                        self.weather = object.weather
                        self.country = object.country
                        self.timezone = object.timezone ?? 0
                        if let countryName = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: object.country?.country ?? "") {
                            self.countryName = countryName
                            self.getLocal()
                        }
                        
                    }
                    return
                }
            }
        }.resume()
    }
    
    
    func getLocal() {
        let timezone = TimeZone(secondsFromGMT: self.timezone)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = timezone
        dateFormatter.timeStyle = .full
        let date = dateFormatter.string(from: Date())
        self.isNight = date.contains("PM")
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
    @State private var country: CitiesObject = Constant.getAllCities()
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
                if searchText.isEmpty || country.filter { ($0.name?.contains(searchText) ?? false)}.isEmpty {
                    VStack(spacing: 20) {
                        Image("warning")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100, alignment: .center)
                            .padding(.top, 200)
                        Text("Sorry, no search results")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.gray)
                            
                        Spacer()
                    }.navigationTitle("Search a City")

                }else {
                    Row(showSelf: $showDetail, selectedCountry: $selectedCountry, searchText: $searchText)
                            .navigationTitle("Choose a City")
                }

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






