//
//  FavoriteCell.swift
//  CountriesFavoriteApp
//
//  Created by Mehmet ÖKSÜZ on 9.11.2023.
//

import UIKit

class FavoriteCell: UITableViewCell {

    struct ViewModel {
        
        let name: String
        let capital: String
        let region: String
        let subregion: String
        let flags: String
        let population: Int
        let data: Country
        
    }
    
    struct WeatherViewModel {
        
        let name: String
        let temp: Double
        let description: String
        let id: Int
        let humidity: String
        let pressure: String
        let lat: Double
        let lon: Double
        let speed: Double
        let country: String
        let sunrise: String
        let sunset: String
        let visibility: Int
        let data: WeatherData
        let weatherType: WeatherType
    }
    
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(countries: ViewModel) {
        
        self.nameLabel.text = countries.name
        let image = countries.flags
        self.flagImage.downloaded(from: image)
        
    }

}

extension FavoriteCell.ViewModel {
    init(response: Country) {
        
        let flagURLString = response.flags["png"] ?? ""
        
        self.init(name: response.name.common,
                  capital: response.capital.first ?? "",
                  region: response.region,
                  subregion: response.subregion,
                  flags: flagURLString,
                  population: response.population,
                  data: response)
    }
}

extension FavoriteCell.WeatherViewModel {
    init(response: WeatherData) {
        
        let percentFormatter = NumberFormatter()
        percentFormatter.numberStyle = .percent
        percentFormatter.maximumFractionDigits = 0
        
        let humidity = "H \(percentFormatter.string(from: NSNumber(value: response.main.humidity / 100.0)) ?? "N/A")"
        
        let hPaFormatter = NumberFormatter()
        hPaFormatter.maximumFractionDigits = 0
        
        let pressure = "P \(hPaFormatter.string(from: NSNumber(value: response.main.pressure)) ?? "N/A") hPa"
        
        let kelvinTemp = response.main.temp
        let celsiusTemp = kelvinTemp - 273.15

        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
         let formattedCelsius = numberFormatter.string(from: NSNumber(value: celsiusTemp))
         let celsiusDouble = Double(formattedCelsius ?? "")
        
        let timestampSunrise = response.sys.sunrise
        let sunriseDate = Date(timeIntervalSince1970: TimeInterval(timestampSunrise))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let sunriseTime = dateFormatter.string(from: sunriseDate)
        let timestampSunset = response.sys.sunset
        let sunsetDate = Date(timeIntervalSince1970: TimeInterval(timestampSunset))
        let sunsetTime = dateFormatter.string(from: sunsetDate)

        self.init(
            name: response.name.uppercased(),
            temp: celsiusDouble ?? 0,
            description: response.weather.map({$0.description}).first ?? "",
            id: response.id,
            humidity: humidity,
            pressure: pressure,
            lat: response.coord.lat,
            lon: response.coord.lon,
            speed: response.wind.speed,
            country: response.sys.country,
            sunrise: sunriseTime,
            sunset: sunsetTime,
            visibility: response.visibility,
            data: response,
            weatherType: response.weather.first?.main ?? .Clouds
        )
        
    }
}

