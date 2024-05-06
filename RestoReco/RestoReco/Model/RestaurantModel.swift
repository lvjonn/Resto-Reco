//
//  RestaurantModel.swift
//  RestoReco
//
//  Created by Aljonn Santos on 2/5/2024.
//

import Foundation

struct RestaurantModel: Codable{
    let id: String
    let name: String
    let isClosed: Bool
    let reviewCount: Int
    let rating: Double
    let price: String?
    let phone: String
    let imageUrl: String?
    
}
