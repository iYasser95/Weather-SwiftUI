//
//  ContentView.swift
//  Weather-SwiftUI
//
//  Created by Apple on 25/12/2020.
//

import SwiftUI
import Network

struct ContentView: View {
    @State private var showDetail = false
    @State private var isNight: Bool = false
    @State private var weather: Weather?
    @State private var selectedCountry: String = "Manama"
    @State private var countries = CitiesObject()
    @State private var country: Country?
    @State private var countryName: String = "Bahrain"
    @State private var timezone: Int = 0
    @State private var isLoading: Bool = true
    @State private var spinner: UIActivityIndicatorView?
    @State private var statusImage: String = ""
    @State private var isConnected: Bool = true
    @State private var state: String = ""
    var body: some View {
        NavigationView {
            if !isConnected {
                VStack {
                    ErrorView(image: "warning", text: "Please check connection")
                        Button(action: {
                           checkNetwork()
                        }) {
                            WeatherButton(title: "Try again",
                                          textColor: .white,
                                          backgroundColor: .gray)
                        }.padding(.top, -350)
                }
            }else {
                if isLoading {
                    LoadingView()
                        .onAppear(perform: loadData)
                        .onAppear(perform: checkNetwork)
                    
                }else {
                    ZStack {
                        
                        BackgroundView(isNight: $isNight)
                            .onAppear {
                                self.statusImage = Constant.shared.getStatusImage(from: state, isNight: isNight)
                            }
                            
                        VStack {
                            let imageName = statusImage
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
                            
                            NavigationLink(destination: ListView(showDetail: $showDetail, selectedCountry: $selectedCountry, isLoading: $isLoading), isActive: $showDetail) {
                                let textColor: Color = isNight ? .black : .blue
                                WeatherButton(title: "Change City",
                                              textColor: textColor,
                                              backgroundColor: .white)
                            }
                            
                            Spacer()
                            
                        }.onAppear(perform: loadData)
                        .onAppear(perform: checkNetwork)
                    }
                }
            }

        }
        
    }
    
    func loadData() {
        guard let url = URL(string: Constant.shared.getUrl(for: selectedCountry)), isLoading else { return }
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
                            self.isLoading = false
                            self.state = object.status?.first?.main ?? ""
                            
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
        let dateAsString = date.formattedDate
        dateFormatter.dateFormat = "h:mm a"
        let formattedDate = dateFormatter.date(from: dateAsString)
        dateFormatter.dateFormat = "HH:mm"
        let date24 = dateFormatter.string(from: formattedDate ?? Date())
        let hour = Int(date24.hour) ?? 0
        switch hour {
        case 5...18:
            self.isNight = false
        default:
            self.isNight = true
        }
    }
    
    
    func checkNetwork()  {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
        isConnected = path.status == .satisfied
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
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

extension String {
    var removeWhiteSpace: String {
       return self.replacingOccurrences(of: " ", with: "")
    }
    
    var formattedDate: String {
        var dateAsString = String(self.components(separatedBy: "GMT").first ?? "")
        dateAsString = dateAsString.replacingOccurrences(of: "PM", with: "")
        dateAsString = dateAsString.replacingOccurrences(of: "AM", with: "")
        return self.removeWhiteSpace
    }
    
    var hour: String {
        let formatted = self.components(separatedBy: ":")
        return formatted.first ?? ""
    }
}
