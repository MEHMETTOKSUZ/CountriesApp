//
//  DetailsVC.swift
//  CountriesFavoriteApp
//
//  Created by Mehmet ÖKSÜZ on 9.11.2023.
//

import UIKit
import MapKit

class DetailsVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var subregionLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humudityLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    var selectedCountry: FavoriteCell.ViewModel?
    let viewModel = WeatherSearchViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCountriesDetails()
        searchCountriesName()
        flagImage.layer.cornerRadius = 30
        
        viewModel.didFinishLoad = {
            self.getWeather()
        }
    }
    
    func getWeather() {
        DispatchQueue.main.async {
            if let data = self.viewModel.weatherDatas.first {
                self.tempLabel.text = String("\(data.temp)°C")
                self.humudityLabel.text = String(data.humidity)
                self.pressureLabel.text = String(data.pressure)
                self.destinationLabel.text = data.description
                self.windSpeedLabel.text = String("Speed: \(data.speed ) m/s")
                self.sunriseLabel.text = "Sunrise: \(data.sunrise)"
                self.sunsetLabel.text = "Sunset: \(data.sunset)"
                let visibilityInKilometers = Double(data.visibility) / 1000.0
                self.visibilityLabel.text = String(format: "Visibility: %.2f km", visibilityInKilometers)
                let locationCoordinate = CLLocationCoordinate2D(latitude: data.lat, longitude: data.lon)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = locationCoordinate
                annotation.title = "Location"
                self.mapView.addAnnotation(annotation)
                self.mapView.setCenter(locationCoordinate, animated: true)
                
            }
        }
    }
    
    func searchCountriesName() {
        
        if let countryName = selectedCountry?.name {
            viewModel.fetchData(city: countryName)
        }
    }
    
    func loadCountriesDetails() {
        self.countryNameLabel.text = selectedCountry?.name
        self.capitalLabel.text = selectedCountry?.capital
        self.regionLabel.text = selectedCountry?.region
        self.subregionLabel.text = selectedCountry?.subregion
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let formattedPopulation = numberFormatter.string(from: NSNumber(value: selectedCountry?.population ?? 0)) {
            self.populationLabel.text = formattedPopulation
        }
        if let image = selectedCountry?.flags {
            flagImage.downloaded(from: image)
        }
    }



}
