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
            
            ZStack{
                if let restaurant = selectedRestaurant {
                    // link to RestaurantDetailsView
                    RestaurantDetailsView(restaurant: restaurant)
                    VStack{
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
                        }
                        Spacer()
                    }
                    .padding(.top, 70)
                } else {
                    VStack{
                        HStack(spacing: 20) {
                            // shuffle button
                            Button(action: {
                                // select random restaurant
                                selectedRestaurant = restoViewModel.restaurants.randomElement()
                            }) {
                                Image(systemName: "shuffle")
                                    .frame(width: 70)
                            }
                            .buttonStyle(CustomButtonStyle())
                            .padding(.bottom)
                        }
                        Text("Press the button to shuffle")
                            .foregroundColor(.secondary)
                            .font(.headline)
                            .padding()
                    }
                }
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


