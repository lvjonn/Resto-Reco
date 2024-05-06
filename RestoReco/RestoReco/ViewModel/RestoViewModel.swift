//
//  RestoViewModel.swift
//  RestoReco
//
//  Created by Aljonn Santos on 6/5/2024.
//

import Foundation

class RestoViewModel: ObservableObject{
    
    @Published var restaurants: [RestaurantModel] = []
    private var yelpApi = YelpFusionAPI()
    
    init(){
        //        yelpApi.searchBusinesses(location: "Sydney") { result in
        //            switch result {
        //            case .success(let fetchedRestaurants):
        //                self.restaurants = fetchedRestaurants
        //            case .failure(let error):
        //                print("Failed to fetch restaurants: \(error)")
        //            }
        //        }
        restaurants = load()
    }
    
    //load json data due to API limits.
    func load() -> [RestaurantModel] {
        var restaurants: [RestaurantModel] = []

        // Get the URL for the tempData.json file
        guard let url = Bundle.main.url(forResource: "tempData", withExtension: "json") else {
            fatalError("Couldn't find tempData.json in the app bundle.")
        }

        do {
            // Load the JSON data from the file
            let data = try Data(contentsOf: url)

            // Decode the JSON data into an array of RestaurantModel objects
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(SearchResponse.self, from: data)
            restaurants = result.businesses
        } catch {
            fatalError("Couldn't parse tempData.json as [RestaurantModel]: \(error)")
        }
        return restaurants
    }
    
    struct SearchResponse: Codable {
        let businesses: [RestaurantModel]
    }


}
