//
//  WeatherModel.swift
//  CountriesFavoriteApp
//
//  Created by Mehmet ÖKSÜZ on 9.11.2023.
//

import Foundation


struct WeatherData: Codable {
    let main: Main
    let weather: [Weather]
    let id: Int
    let name: String
    let visibility: Int
    let coord: Coord
    let wind: Wind
    let sys: Sys
    
}

struct Main: Codable {
    let temp: Double
    let humidity: Double
    let pressure: Double
  
}

struct Weather: Codable {
    
    let main: WeatherType
    let description: String
    let icon: String
    
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct Sys: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}

enum WeatherType: String, Codable {
    
    case Thunderstorm
    case Drizzle
    case Rain
    case Snow
    case Mist
    case Smoke
    case Haze
    case Dust
    case Fog
    case Sand
    case Ash
    case Squall
    case Tornado
    case Clear
    case Clouds
    
}
