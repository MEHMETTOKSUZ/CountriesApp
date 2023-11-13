//
//  WeatherViewModel.swift
//  CountriesFavoriteApp
//
//  Created by Mehmet ÖKSÜZ on 9.11.2023.
//

import Foundation

class WeatherSearchViewModel {
    
    var didFinishLoad: (() -> Void)?
    var didFinishLoadWithError: ((String) -> Void)?
    var weatherDatas: [FavoriteCell.WeatherViewModel] = []
    
    func fetchData(city: String) {
        
        guard let stringUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(LocaleKeys.API_ID)") else {
            print("Invalid URL")
            return
        }
        
        WebService().fetchData(from: stringUrl) { (result: Result<WeatherData, Error>) in
            switch result {
            case .success(let data):
                self.presentWeatherData(result: data)
            case .failure(let error):
                self.didFinishLoadWithError?(error.localizedDescription)
            }
        }
    }
    
    func presentWeatherData(result: WeatherData) {
        let model = FavoriteCell.WeatherViewModel(response: result)
        self.weatherDatas = [model]
        self.didFinishLoad?()
    }
}
