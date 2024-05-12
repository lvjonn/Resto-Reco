//
//  PlannerDetailsView.swift
//  RestoReco
//
//  Created by Aljonn Santos on 12/5/2024.
//

import SwiftUI

struct PlannerDetailsView: View {
    @EnvironmentObject var restoViewModel: RestoViewModel
    @State var planner: PlannerModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: planner.restaurant.imageUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
            }
            .frame(height: 175)
            .cornerRadius(8)
            
            HStack(spacing: 10) {
                Spacer()
                VStack(alignment: .leading){
                    Text(planner.restaurant.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                    
                    Text("\(String(format: "%.1f", planner.restaurant.rating)) \(Image(systemName: "star.fill")) ")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                    Text("Reviews: \(planner.restaurant.reviewCount)")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                    if let price = planner.restaurant.price{
                        Text("Price: \(price)")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                    }
                    Text("\(Image(systemName: "location.fill")) \(planner.restaurant.location.displayAddress.joined(separator: ", "))")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                    Text("\(Image(systemName: "phone.fill")) \(planner.restaurant.phone)")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                    if let url = planner.restaurant.attributes.menuUrl{
                        Text("\(Image(systemName: "link")) \(url)")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                    }
                    
                }
                Spacer()
            }
            
            DatePicker("Schedule:", selection: $planner.date)
                .colorMultiply(Color.black)
                .colorInvert()
                .datePickerStyle(DefaultDatePickerStyle())
                .labelsHidden()
                .background(Color.red.opacity(0.9))
                .cornerRadius(10)
                .shadow(radius: 5)
            
            HStack{
                VStack(alignment: .leading){
                    Text("Notes")
                        .font(.title3)
                        .bold()
                        .padding(.leading)
                    TextEditor(text: Binding<String>(
                        get: { planner.notes ?? "" },
                        set: { planner.notes = $0 }
                    ))
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .foregroundColor(.black)
                    .padding([.leading, .trailing], 10)
                    .padding(.top, 2)
                    .padding(.bottom, 2)
                }
                
            }
            .padding()
            
            HStack{
                Button(action:{
                    restoViewModel.updatePlanner(planned: planner)
                }){
                    Text("Save")
                }.buttonStyle(CustomButtonStyle())
                
                Button(action:{
                    restoViewModel.deletePlanner(planned: planner)
                    presentationMode.wrappedValue.dismiss()
                }){
                    Text("Delete")
                }.buttonStyle(CustomButtonStyle())
            }
            
        }
        .padding(.bottom)
    }
}

#Preview {
    PlannerDetailsView(planner: PlannerModel(restaurant: RestoViewModel().randomRestaurant()!, date: Date())).environmentObject(RestoViewModel())
}
