//
//  Tab.swift
//  RestoReco
//
//  Created by Aljonn Santos on 10/5/2024.
//

import Foundation

enum Tab: String, CaseIterable{
    case restaurants = "Restaurants"
    case planner = "Planer"
    case shuffle = "Shuffle"
    case toporbottom = "TopOrBottom"
    
    var systemImage: String{
        switch self {
        case .restaurants:
            return "storefront"
        case .planner:
            return "calendar"
        case .shuffle:
            return "shuffle"
        case .toporbottom:
            return "arrowshape.left.arrowshape.right.fill"
        }
    }
    
    var index: Int{
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
    
}
