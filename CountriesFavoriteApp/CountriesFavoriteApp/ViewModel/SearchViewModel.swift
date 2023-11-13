//
//  SearchViewModel.swift
//  CountriesFavoriteApp
//
//  Created by Mehmet ÖKSÜZ on 9.11.2023.
//

import Foundation

class SearchViewModel {
    
    var didFinishLoad: (() ->Void)?
    var didFinshLoadWithError: ((String) -> Void)?
    var countries: [FavoriteCell.ViewModel] = []
    
    func getCountry(name: String) {
           guard let url = URL(string: "https://restcountries.com/v3.1/name/\(name)") else {
               print("Invalid URL")
               return
           }
           
           WebService().fetchData(from: url) { (result: Result<[Country], Error>) in
               switch result {
               case .success(let data):
                   if data.isEmpty {
                       self.didFinshLoadWithError?("Country not found")
                   } else {
                       self.presentResult(result: data)
                       print(data)
                       self.didFinishLoad?()
                   }
               case .failure(let error):
                   self.didFinshLoadWithError?(error.localizedDescription)
               }
           }
       }
    
    func presentResult(result: [Country]) {
        
        let viewModel: [FavoriteCell.ViewModel] = result.map({ results in
            FavoriteCell.ViewModel(response: results)
        })
        self.countries = viewModel
        self.didFinishLoad?()
    }
}
