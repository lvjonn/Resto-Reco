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
    
    var body: some View {
        VStack{
            RestaurantOverview(restaurant: restoViewModel.randomRestaurant()!)
            DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                .colorMultiply(Color.black)
                .colorInvert()
                .datePickerStyle(DefaultDatePickerStyle()) // Use a different style if desired
                .labelsHidden() // Hide the "Date" label
                .background(Color.red.opacity(0.9)) // Add a background color
                .cornerRadius(10) // Add corner radius
                .shadow(radius: 5) // Add a shadow
                .padding() // Add additional padding
            
            Button("Add", action: {})
                .buttonStyle(CustomButtonStyle())
        }
        
    }
}

#Preview {
    AddPlannerView().environmentObject(RestoViewModel())
}
