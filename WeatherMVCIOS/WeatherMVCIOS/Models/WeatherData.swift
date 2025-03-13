//
//  File.swift
//  WeatherMVCIOS
//
//  Created by Evseev George on 13.03.25.
//

import Foundation

// MARK: - WeatherData Model
struct WeatherData: Decodable {
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
    let humidity: Int
}

struct Weather: Decodable {
    let description: String
}

