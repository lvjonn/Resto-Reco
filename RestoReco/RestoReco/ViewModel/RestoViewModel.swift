//
//  RestoViewModel.swift
//  RestoReco
//
//  Created by Aljonn Santos on 6/5/2024.
//

import Foundation
import MapKit

class RestoViewModel: ObservableObject{
    
    @Published var restaurants: [RestaurantModel]
    var yelpApi = YelpFusionAPI()
    @Published var optionOne: RestaurantModel?
    @Published var optionTwo: RestaurantModel?
    
    
    @Published var planner: [PlannerModel] = []
    
    init(){
        self.restaurants = []
        //Use this if there are still available API requests, otherwise, use the cached data.
        self.yelpApi.searchBusinesses(location: "Hay Market New South Wales") { result in
            switch result {
            case .success(let fetchedRestaurants):
                DispatchQueue.main.async{
                    self.restaurants = fetchedRestaurants
                }
            case .failure(let error):
                print("Failed to fetch restaurants: \(error)")
            }
        }
//                restaurants = loadRestaurants() //use this if using cached data
        self.planner = loadPlanner()
    }
    
    func setTopOrBottom(){
        if(restaurants.isEmpty){
            optionOne = nil
            optionTwo = nil
            return
        }
        while(true){
            optionOne = randomRestaurant()
            optionTwo = randomRestaurant()
            if optionOne == nil || optionTwo == nil{
                continue
            }
            if optionOne?.id != optionTwo?.id{ //ensures its not the same.
                break
            }
        }
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
    
    //save planner to planner.json file.
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
    //file path
    private func filePathInDocumentsDirectory(for filename: String) -> URL? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent(filename)
    }
    
    //decode json file into [PlannerModel]
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
        }
        return restaurants
    }
    //refresh top option
    func changeOptionOne(){
        while(true){
            optionOne = randomRestaurant()
            if optionOne?.id != optionTwo?.id{
                break
            }
        }
    }
    //refresh bottom option
    func changeOptionTwo(){
        while(true){
            optionTwo = randomRestaurant()
            if optionOne?.id != optionTwo?.id{
                break
            }
        }
    }
    //choose random restaurant
    func randomRestaurant() -> RestaurantModel?{
        return restaurants.randomElement()
    }
    //filter history data
    func historyPlanner() -> [PlannerModel] {
        let currentDate = Date()
        let filteredPlanner = planner.filter { plannerItem in
            return plannerItem.date < currentDate
        }
        return filteredPlanner
    }
    //filter planned data
    func plannedPlanner() -> [PlannerModel] {
        let currentDate = Date()
        let filteredPlanner = planner.filter { plannerItem in
            return plannerItem.date >= currentDate
        }
        return filteredPlanner
    }
    //delete planner
    func deletePlanner(planned: PlannerModel) {
        if let index = planner.firstIndex(where: { $0.id == planned.id }) {
            planner.remove(at:index)
        }
        savePlanner()
    }
    //update planner record
    func updatePlanner(planned: PlannerModel) {
        if let index = planner.firstIndex(where: { $0.id == planned.id }) {
            planner[index] = planned
        }
        savePlanner()
    }
    
    
    
    
}
