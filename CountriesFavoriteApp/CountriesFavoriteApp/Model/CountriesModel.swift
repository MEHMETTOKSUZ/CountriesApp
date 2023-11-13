//
//  CountriesModel.swift
//  CountriesFavoriteApp
//
//  Created by Mehmet ÖKSÜZ on 9.11.2023.
//

import Foundation

struct Country: Codable {
    let name: Name
    let capital: [String]
    let region: String
    let subregion: String
    let flags: [String: String]
    let population: Int
}

struct Name: Codable {
    let common, official: String
}
