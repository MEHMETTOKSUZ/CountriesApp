//
//  WebService.swift
//  CountriesFavoriteApp
//
//  Created by Mehmet ÖKSÜZ on 9.11.2023.
//

import Foundation


class WebService {
    let decoder: JSONDecoder
    
    init() {
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func fetchData<T: Codable>(from url: URL, completion: @escaping(Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            do {
                let result = try self.decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch let decodingError {
                let errorDescription = "Decoding error: \(decodingError.localizedDescription)"
                completion(.failure(decodingError))
                print(errorDescription)
            }
        }.resume()
    }
    
}
