//
//  Tab.swift
//  RestoReco
//
//  Created by Aljonn Santos on 10/5/2024.
//

import Foundation

enum Tab: String, CaseIterable{
    case restaurants = "Restaurants"
    case planner = "Planner"
    case shuffle = "Shuffle"
    case toporbottom = "Top/Bottom"
    
    var systemImage: String{
        switch self {
        case .restaurants:
            return "storefront"
        case .planner:
            return "calendar"
        case .shuffle:
            return "shuffle"
        case .toporbottom:
            return "arrow.up.arrow.down"
        }
    }
    
    var index: Int{
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
    
}
