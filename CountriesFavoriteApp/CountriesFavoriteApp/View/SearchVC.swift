//
//  SearchVC.swift
//  CountriesFavoriteApp
//
//  Created by Mehmet ÖKSÜZ on 9.11.2023.
//

import UIKit

class SearchVC: UIViewController, UISearchBarDelegate {

    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryNameLabel.isHidden = true
        favoriteButton.isHidden = true
        
        view.addSubview(searchBar)
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBar.delegate = self
        updateFavoriteButtonState()
        
        viewModel.didFinishLoad = {
            DispatchQueue.main.async {
                self.getSearchResults()
            }
        }
    }
    
    func getSearchResults() {
        if let data = viewModel.countries.first {
            self.countryNameLabel.text = data.name
            updateFavoriteButtonState()
            countryNameLabel.isHidden = false
            favoriteButton.isHidden = false
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let query = searchBar.text, !query.isEmpty else {
            return
        }
        
        viewModel.getCountry(name: query)
        
    }
    
    
    @IBAction func favoriteButtonClicked(_ sender: Any) {
        
        guard let selectedViewModelData = viewModel.countries.first else {
            return
        }
        
        let selectedData = selectedViewModelData.data
        if FavoriteManeger.shared.isCityFavorite(city: selectedData) {
            FavoriteManeger.shared.removeCountryInFavorites(country: selectedData)
        } else {
            FavoriteManeger.shared.toggleCityFavoriteStatus(country: selectedData)
        }
        updateFavoriteButtonState()
        navigationController?.popViewController(animated: true)
        
    }
    
    func updateFavoriteButtonState() {
        guard let selectedViewModel = viewModel.countries.first else {
            return
        }
        
        let selectedCountriesWeatherData = selectedViewModel.data
        
        if FavoriteManeger.shared.isCityFavorite(city: selectedCountriesWeatherData) {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    

}
