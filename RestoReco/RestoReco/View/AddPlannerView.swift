//
//  AddPlannerView.swift
//  RestoReco
//
//  Created by Aljonn Santos on 12/5/2024.
//

import SwiftUI

struct AddPlannerView: View {
    @EnvironmentObject var restoViewModel: RestoViewModel
    @State private var selectedDate = Date()
    var restaurant: RestaurantModel
    
    var body: some View {
        VStack{
            Spacer()
            MoreDetails(restaurant: restaurant)
            HStack{
                Text("\(Image(systemName: "calendar"))")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.black)
                
                DatePicker("Schedule:", selection: $selectedDate)
                    .colorMultiply(Color.black)
                    .colorInvert()
                    .datePickerStyle(DefaultDatePickerStyle())
                    .labelsHidden()
                    .background(Color.red.opacity(0.9))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()
            }
            Spacer()
            Button("Add to Planner", action: {
                
            })
                .buttonStyle(CustomButtonStyle())
        }
        
    }
}

struct MoreDetails: View {
    let restaurant: RestaurantModel

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack{
                Spacer()
                if let imageUrl = restaurant.imageUrl, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 200)
                    .cornerRadius(8)
                    .padding(.top, 15)
                }
                Spacer()
            }

            VStack(alignment: .leading){
                Text(restaurant.name)
                    .font(.title)
                    .fontWeight(.bold)
                Text("\(Image(systemName: "location.fill")) \(restaurant.location.displayAddress.joined(separator: ", "))")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                Text("\(Image(systemName: "phone.fill")) \(restaurant.phone)")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                if let url = restaurant.attributes.menuUrl{
                    Text("\(Image(systemName: "link")) \(url)")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }
            }.padding(.horizontal)
            
            Spacer()
        }
    }
}


#Preview {
    AddPlannerView(restaurant: RestoViewModel().randomRestaurant()!).environmentObject(RestoViewModel())
}
