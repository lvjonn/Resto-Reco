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
        yelpApi.searchBusinesses(location: "Sydney") { result in
            switch result {
            case .success(let fetchedRestaurants):
                self.restaurants = fetchedRestaurants
            case .failure(let error):
                print("Failed to fetch restaurants: \(error)")
            }
        }

    }
}
