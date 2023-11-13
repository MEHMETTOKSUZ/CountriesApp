//
//  ViewController.swift
//  CountriesFavoriteApp
//
//  Created by Mehmet ÖKSÜZ on 9.11.2023.
//

import UIKit

class FavoriteVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = FavoriteViewModel()
    let weatherViewModel = WeatherSearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.didFinishLoad = {
            self.tableView.reloadData()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        

    }
  
 
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadFavoritesCountries()
    }
  
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toSearchVC", sender: nil)
    }
}


extension FavoriteVC: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoriteCell
        cell.selectionStyle = .none
        cell.layer.cornerRadius = 30
        cell.backgroundColor = .systemGray6
        let data = viewModel.getFavorites(at: indexPath.row)
        cell.configure(countries: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let cityRemove = viewModel.countries[indexPath.row]
            FavoriteManeger.shared.removeCountryInFavorites(country: cityRemove.data)
            viewModel.countries.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountries = viewModel.getFavorites(at: indexPath.row)
        performSegue(withIdentifier: "toDetailsVC", sender: selectedCountries)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as? DetailsVC
            if let indexPath = tableView.indexPathForSelectedRow {
               let selectedCountries = viewModel.getFavorites(at: indexPath.row)
                destinationVC?.selectedCountry = selectedCountries
            }
        }
    }

}

