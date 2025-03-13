//
//  File.swift
//  WeatherMVCIOS
//
//  Created by Evseev George on 13.03.25.
//

import Foundation

// MARK: - Weather Service
class WeatherService {
    private let networkProvider: NetworkProvider
    private let apiKey = "fc606b36609785cb7ce4ee134a6dec06"
    private let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
    
    init(networkProvider: NetworkProvider = NetworkProvider()) {
        self.networkProvider = networkProvider
    }
    
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let urlString = "\(baseUrl)?q=\(city)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else { return }
        
        networkProvider.fetchData(from: url) { (result: Result<WeatherData, Error>) in
            switch result {
            case .success(let weatherData):
                completion(.success(weatherData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

