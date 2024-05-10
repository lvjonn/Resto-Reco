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
    var optionOne: RestaurantModel?
    var optionTwo: RestaurantModel?
    
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
        optionOne = randomRestaurant()
        while(true){
            optionTwo = randomRestaurant()
            if optionOne?.id != optionTwo?.id{ //ensures its not the same.
                break
            }
        }
    }
    
    //load json data due to API limits.
    func load() -> [RestaurantModel] {
        var restaurants: [RestaurantModel] = []
        
        // Get the URL for the tempData.json file
        guard let url = Bundle.main.url(forResource: "export", withExtension: "json") else {
            fatalError("Couldn't find export.json in the app bundle.")
        }
        
        do {
            // Load the JSON data from the file
            let data = try Data(contentsOf: url)
            
            // Decode the JSON data into an array of RestaurantModel objects
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            restaurants = try decoder.decode([RestaurantModel].self, from: data)
        } catch {
            fatalError("Couldn't parse export.json as [RestaurantModel]: \(error)")
        }
        return restaurants
    }
     
    func exportData(){
        let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted

            do {
                let data = try encoder.encode(restaurants)
                let projectFolderURL = URL(fileURLWithPath: #file).deletingLastPathComponent().deletingLastPathComponent()
                let fileURL = projectFolderURL.appendingPathComponent("Services/export.json")
                try data.write(to: fileURL)
                print("Restaurants saved to: \(fileURL)")
            } catch {
                print("Error saving restaurants: \(error)")
            }
    }
    
    func changeOptionOne(){
        while(true){
            optionOne = randomRestaurant()
            if optionOne?.id != optionTwo?.id{
                break
            }
        }
    }
    func changeOptionTwo(){
        while(true){
            optionTwo = randomRestaurant()
            if optionOne?.id != optionTwo?.id{
                break
            }
        }
    }
    
    func randomRestaurant() -> RestaurantModel?{
        return restaurants.randomElement()
    }
    
    
}
