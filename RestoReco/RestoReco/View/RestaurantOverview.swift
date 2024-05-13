//
//  RestaurantOverview.swift
//  RestoReco
//
//  Created by Aljonn Santos on 11/5/2024.
//

import SwiftUI

//reusable view for displaying restaurant overview
struct RestaurantOverview: View{
    var restaurant: RestaurantModel //restaurant instance
    var body: some View{
        HStack(spacing: 20) {
            Spacer()
            AsyncImage(url: URL(string: restaurant.imageUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
            } placeholder: {
                ProgressView() //loading view when image is processing.
            }
            .frame(width: 125, height: 125)
            .cornerRadius(8)
            
            VStack(alignment: .leading){
                Text(restaurant.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                
                Text("\(String(format: "%.1f", restaurant.rating)) \(Image(systemName: "star.fill")) ")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                Text("Reviews: \(restaurant.reviewCount)")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                if let price = restaurant.price{
                    Text("Price: \(price)")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }
                
            }
            Spacer()
        }
    }
    
}

#Preview {
    RestaurantOverview(restaurant: RestoViewModel().randomRestaurant()!)
}
