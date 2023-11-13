//
//  FavoriteManager.swift
//  CountriesFavoriteApp
//
//  Created by Mehmet ÖKSÜZ on 9.11.2023.
//

import Foundation

class FavoriteManeger {
    
    static  let shared = FavoriteManeger()
    private let userdefaults = UserDefaults.standard
    private let favoriteKey = "favoriteCountry"
    
    var favoritesCountries: [Country] = []
    
    init() {
        if let data = userdefaults.data(forKey: favoriteKey),
           let favorites = try? JSONDecoder().decode([Country].self, from: data) {
            favoritesCountries = favorites
            
        }
    }
    
    func toggleCityFavoriteStatus(country: Country) {
        
        if let index = favoritesCountries.firstIndex(where: { $0.name.official == country.name.official }) {
            favoritesCountries.remove(at: index)
        } else {
            favoritesCountries.append(country)
        }
        saveFavoriteCities()
    }
    
    func getFavoriteCounties() -> [Country] {
        
        return favoritesCountries
    }
    
    func isCityFavorite(city: Country) -> Bool {
        return favoritesCountries.contains(where: { $0.name.official == city.name.official })
    }
    
    func removeCountryInFavorites(country: Country) {
        if let index = favoritesCountries.firstIndex(where: { $0.name.official == country.name.official }) {
            favoritesCountries.remove(at: index)
            saveFavoriteCities()
            
        }
    }
    
    private func saveFavoriteCities() {
        if let encode = try? JSONEncoder().encode(favoritesCountries) {
            userdefaults.set(encode, forKey: favoriteKey)
        }
    }
    
    
}
