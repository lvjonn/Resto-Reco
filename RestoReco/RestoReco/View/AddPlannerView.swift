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
            RestaurantOverview(restaurant: restaurant)
            HStack{
                Text("Date:")
                    .font(.title3)
                    .bold()
                DatePicker("Schedule:", selection: $selectedDate)
                    .colorMultiply(Color.black)
                    .colorInvert()
                    .datePickerStyle(DefaultDatePickerStyle()) // Use a different style if desired
                    .labelsHidden() // Hide the "Date" label
                    .background(Color.red.opacity(0.9)) // Add a background color
                    .cornerRadius(10) // Add corner radius
                    .shadow(radius: 5) // Add a shadow
                    .padding() // Add additional padding
            }
            Spacer()
            Button("Add to Planner", action: {})
                .buttonStyle(CustomButtonStyle())
        }
        
    }
}

#Preview {
    AddPlannerView(restaurant: RestoViewModel().randomRestaurant()!).environmentObject(RestoViewModel())
}
