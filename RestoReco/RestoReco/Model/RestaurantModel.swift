//
//  RestaurantModel.swift
//  RestoReco
//
//  Created by Aljonn Santos on 2/5/2024.
//

import Foundation

struct RestaurantModel: Identifiable, Codable {
    var id: String
    var alias: String
    var name: String
    var imageUrl: String?
    var isClosed: Bool
    var url: String
    var reviewCount: Int
    var categories: [Category]
    var rating: Double
    var coordinates: Coordinates
    var transactions: [String]
    var price: String?
    var location: Location
    var phone: String
    var displayPhone: String
    var distance: Double
    var attributes: Attributes
    
    struct Category: Codable {
        var alias: String
        var title: String
    }
    
    struct Coordinates: Codable {
        var latitude: Double
        var longitude: Double
    }
    
    struct Location: Codable {
        var address1: String
        var address2: String?
        var address3: String?
        var city: String
        var zipCode: String
        var country: String
        var state: String
        var displayAddress: [String]
    }
    
    struct Attributes: Codable {
        var businessTempClosed: Bool?
        var menuUrl: String?
        var open24Hours: Bool?
        var waitlistReservation: Bool?
    }
}
