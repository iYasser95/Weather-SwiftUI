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
    @State private var selectedCity: String = Constant.strings.defaultCity
    @State private var countries = CitiesObject()
    @State private var country: Country?
    @State private var countryName: String = Constant.strings.defaultCountry
    @State private var timezone: Int = 0
    @State private var isLoading: Bool = true
    @State private var spinner: UIActivityIndicatorView?
    @State private var statusImage: String = ""
    @State private var isConnected: Bool = true
    @State private var state: String = ""
    private var client = WeatherClient.shared
    var body: some View {
        NavigationView {
            if !isConnected {
                VStack {
                    ErrorView(image: Constant.strings.warningImage, text: Constant.strings.checkConnection)
                        Button(action: {
                           checkNetwork()
                        }) {
                            WeatherButton(title: Constant.strings.tryAgain,
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
                            CityTextView(cityName: selectedCity)
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
                                WeatherDayView(title: Constant.strings.feelsLike,
                                               description: "\(weather?.feelsLike ?? 0)°")
                                
                                WeatherDayView(title: Constant.strings.humidity,
                                               description: "\(weather?.humidity ?? 0)%")
                                
                                WeatherDayView(title: Constant.strings.pressure,
                                               description: "\(weather?.pressure ?? 0) hPa")
                                
                            }
                            Spacer()
                            
                            NavigationLink(destination: ListView(showDetail: $showDetail, selectedCity: $selectedCity, isLoading: $isLoading), isActive: $showDetail) {
                                let textColor: Color = isNight ? .black : .blue
                                WeatherButton(title: Constant.strings.changeCity,
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
        guard isLoading else { return }
        client.loadWeatherData(for: selectedCity) { (object, eror) in
            DispatchQueue.main.async {
                self.weather = object?.weather
                self.country = object?.country
                self.timezone = object?.timezone ?? 0
                let countryCode = object?.country?.country ?? ""
                if let countryName = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: countryCode) {
                    self.countryName = countryName
                    self.isLoading = false
                    self.state = object?.status?.first?.main ?? ""
                    self.getLocal()

                }
                
            }
        }
    }
    
    
    func getLocal() {
        let hour = Constant.shared.getLocal(from: self.timezone)
        switch hour {
        case 5...17:
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




