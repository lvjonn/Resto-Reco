//
//  ShuffleView.swift
//  RestoReco
//
//  Created by Aljonn Santos on 6/5/2024.
//

import SwiftUI

struct ShuffleView: View {
    @EnvironmentObject var restoViewModel: RestoViewModel
    @State private var selectedRestaurant: RestaurantModel?

    var body: some View {
        VStack {
            
            HStack(spacing: 20) {
                // shuffle button
                Button(action: {
                    selectedRestaurant = restoViewModel.restaurants.randomElement()
                }) {
                    Image(systemName: "shuffle")
                        .frame(width: 70)
                }
                .buttonStyle(CustomButtonStyle())
                .padding(.bottom)
                
                // add to planner button
                if selectedRestaurant != nil {
                    Button(action: {
                        selectedRestaurant = restoViewModel.restaurants.randomElement()
                    }) {
                        Image(systemName: "calendar")
                            .frame(width: 70)
                    }
                    .buttonStyle(CustomButtonStyle())
                    .padding(.bottom)
                }
            }
            
            if let restaurant = selectedRestaurant {
                RestaurantDetailsView(restaurant: restaurant)
            } else {
                Text("No restaurant selected")
                    .foregroundColor(.secondary)
                    .font(.headline)
                    .padding()
            }
        }
        .navigationTitle("Shuffle")
    }
}

struct ShuffleView_Previews: PreviewProvider {
    static var previews: some View {
        ShuffleView()
            .environmentObject(RestoViewModel())
    }
}


