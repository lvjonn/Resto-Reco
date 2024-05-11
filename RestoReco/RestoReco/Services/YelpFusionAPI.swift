//
//  YelpFusionAPI.swift
//  RestoReco
//
//  Created by Aljonn Santos on 2/5/2024.
//

import Foundation

class YelpFusionAPI{
    //hard coded API key for tutor's use only.
    let apiKey = "qx5DtbKFg4QsLSR5wvD03rBLYzbpE_9WfMkqE-8pPRJzfJWBYafTpWbKA60jc3OgmAb07oWWsZ1EpvTt7KsFAWA5ofFfujC5lapEBuReGF5xGRKDgpcxfqUZM08zZnYx"
    
    func searchBusinesses(location: String, categories: String? = nil, completion: @escaping (Result<[RestaurantModel], Error>) -> Void) {
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")!
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "location", value: location),
            URLQueryItem(name: "sort_by", value: "best_match"),
            URLQueryItem(name: "limit", value: "50")
        ]
        
        if let categories = categories {
            queryItems.append(URLQueryItem(name: "categories", value: categories))
        }
        
        urlComponents.queryItems = queryItems
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(SearchResponse.self, from: data)
                completion(.success(result.businesses))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    struct SearchResponse: Codable {
        let businesses: [RestaurantModel]
    }

    func getBusinessDetails(forId id: String, completion: @escaping (Result<RestaurantModel, Error>) -> Void) {
        let url = URL(string: "https://api.yelp.com/v3/businesses/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(RestaurantModel.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
