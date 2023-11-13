//
//  FavoriteViewModel.swift
//  CountriesFavoriteApp
//
//  Created by Mehmet ÖKSÜZ on 9.11.2023.
//

import Foundation

class FavoriteViewModel {
    
    var didFinishLoad: (() -> Void)?
    var didFinishLoadWithError: ((String) -> Void)?
    var countries: [FavoriteCell.ViewModel] = []
    
    var numberOfInSection: Int {
        return countries.count
    }
    
    func getFavorites(at index: Int) -> FavoriteCell.ViewModel {
        return countries[index]
    }
    
    func loadFavoritesCountries() {
        
        if let data = UserDefaults.standard.object(forKey: "favoriteCountry") as? Data{
            if let favorites = try? JSONDecoder().decode([Country].self, from: data) {
                self.presentResults(result: favorites)
            } else {
                self.didFinishLoadWithError?("Error")
            }
            
        }
    }
    
    func presentResults(result: [Country]) {
        
        let viewModel: [FavoriteCell.ViewModel] = result.map { results in
            FavoriteCell.ViewModel(response: results)
        }
        self.countries = viewModel
        self.didFinishLoad?()
    }
}


