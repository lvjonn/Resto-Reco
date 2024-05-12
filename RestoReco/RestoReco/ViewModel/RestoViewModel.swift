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
    
    
    
    @Published var planner: [PlannerModel] = []
    
    init(){
        //Use this if there are still available API requests, otherwise, use the cached data.
        //        yelpApi.searchBusinesses(location: "Sydney") { result in
        //            switch result {
        //            case .success(let fetchedRestaurants):
        //                self.restaurants = fetchedRestaurants
        //            case .failure(let error):
        //                print("Failed to fetch restaurants: \(error)")
        //            }
        //        }
        restaurants = loadRestaurants()
        optionOne = randomRestaurant()
        while(true){
            optionTwo = randomRestaurant()
            if optionOne?.id != optionTwo?.id{ //ensures its not the same.
                break
            }
        }
        planner = loadPlanner()
    }
    
    //load json data due to API limits.
    func loadRestaurants() -> [RestaurantModel] {
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
    
    func savePlanner(){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(planner)
            guard let fileURL = filePathInDocumentsDirectory(for: "planner.json") else {
                fatalError("Couldn't find planner.json in the app bundle.")
            }
            try data.write(to: fileURL)
            print("Restaurants saved to: \(fileURL)")
        } catch {
            print("Error saving restaurants: \(error)")
        }
    }
    
    private func filePathInDocumentsDirectory(for filename: String) -> URL? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent(filename)
    }

    
    func loadPlanner() -> [PlannerModel] {
        var restaurants: [PlannerModel] = []
        
        // Get the URL for the tempData.json file
        guard let url = filePathInDocumentsDirectory(for: "planner.json") else {
            fatalError("Couldn't find planner.json in the app bundle.")
        }
        
        do {
            // Load the JSON data from the file
            let data = try Data(contentsOf: url)
            
            // Decode the JSON data into an array of RestaurantModel objects
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            restaurants = try decoder.decode([PlannerModel].self, from: data)
        } catch {
            print("Returning blank array: \(error)")
//            fatalError("Couldn't parse planner.json as [PlannerModel]: \(error)")
        }
        return restaurants
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
    
    func historyPlanner() -> [PlannerModel] {
        let currentDate = Date()
        let filteredPlanner = planner.filter { plannerItem in
            return plannerItem.date < currentDate
        }
        return filteredPlanner
    }
    func plannedPlanner() -> [PlannerModel] {
        let currentDate = Date()
        let filteredPlanner = planner.filter { plannerItem in
            return plannerItem.date >= currentDate
        }
        return filteredPlanner
    }
    
    private func deletePlanner(planned: PlannerModel) {
        if let index = planner.firstIndex(where: { $0.id == planned.id }) {
            planner.remove(at:index)
        }
        savePlanner()
    }
    
    
}
