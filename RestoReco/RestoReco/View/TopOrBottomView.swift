//
//  TopOrBottomView.swift
//  RestoReco
//
//  Created by Aljonn Santos on 6/5/2024.
//

import SwiftUI

struct TopOrBottomView: View {
    @EnvironmentObject var restoViewModel: RestoViewModel
    @State var choiceCount = 0
    @State private var topOrBottom = ""
    @State var show = false
    @State var winner: RestaurantModel? = nil
    
    var body: some View {
        NavigationStack{
            VStack{
                if choiceCount < 5{ //limit of 5 iterations of choosing.
                    VStack(alignment: .leading, spacing: 8) {
                        Button(action: {
                            choiceCount += 1
                            topOrBottom = "top" //determines which to display at the end
                            winner = restoViewModel.optionOne //set current choice
                            restoViewModel.changeOptionTwo() //change other option
                        }){
                            if let unwrapped = restoViewModel.optionOne{
                                RestaurantOverview(restaurant: unwrapped)
                                    .padding(.vertical)
                                    .background(Color(.systemBackground))
                                    .cornerRadius(8)
                                    .shadow(radius: 8)
                            }
                            
                        }
                        .padding()
                        
                        HStack{
                            Spacer()
                            VStack {
                                Image(systemName: "arrow.up.arrow.down.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 50, maxHeight: 50)
                                    .foregroundColor(.red)
                                    .foregroundStyle(.tint)
                                .padding(.bottom)
                                if(restoViewModel.restaurants.isEmpty){
                                    Text("Please search a valid location first.")
                                        .foregroundColor(.secondary)
                                        .font(.headline)
                                        .padding()
                                }
                            }
                            Spacer()
                        }
                        .padding(20)
                        
                        Button(action: {
                            choiceCount += 1
                            topOrBottom = "bottom"
                            winner = restoViewModel.optionTwo
                            restoViewModel.changeOptionOne()
                        }){
                            if let unwrapped = restoViewModel.optionTwo{
                                RestaurantOverview(restaurant: unwrapped)
                                    .padding(.vertical)
                                    .background(Color(.systemBackground))
                                    .cornerRadius(8)
                                    .shadow(radius: 8)
                            }
                        }
                        .padding()
                    }
                    .onAppear(){
                        restoViewModel.setTopOrBottom()
                    }
                    .padding(.vertical, 8)
                }else{
                    //choice view
                    VStack{
                        Spacer()
                        Text("Winner!") //change to get date of plan
                            .font(.title)
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                            .padding(.vertical, 5)
                            .padding(.horizontal,15)
                            .background(Color(Color.orange).opacity(0.1))
                            .clipShape(Capsule())
                        HStack{
                            Spacer()
                            if topOrBottom == "top"{
                                if let unwrapped = restoViewModel.optionOne{
                                    NavigationLink(destination: RestaurantDetailsView(restaurant: unwrapped)){
                                        RestaurantOverview(restaurant: unwrapped)
                                            .padding()
                                            .background(Color(.systemBackground))
                                            .cornerRadius(8)
                                            .shadow(radius: 8)
                                    }
                                }
                            }else{
                                if let unwrapped = restoViewModel.optionTwo{
                                    NavigationLink(destination: RestaurantDetailsView(restaurant: unwrapped)){
                                        RestaurantOverview(restaurant: unwrapped)
                                            .padding()
                                            .background(Color(.systemBackground))
                                            .cornerRadius(8)
                                            .shadow(radius: 8)
                                    }
                                }
                            }
                            Spacer()
                        }
                        .padding(.top)
                        Button(action:{show = true}){
                            Text("Add to Planner")
                        }
                        .buttonStyle(CustomButtonStyle())
                        .padding(.top)
                        Spacer()
                        Button(action:{
                            choiceCount = 0
                        }){
                            VStack{
                                Image(systemName: "restart.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 50, maxHeight: 50)
                                    .foregroundColor(.red)
                                    .foregroundStyle(.tint)
                                Text("Restart")
                                    .foregroundStyle(Color(.red))
                            }
                        }
                        
                    }
                    
                }
            }
        }
        .sheet(isPresented: $show, content: {
            if let unwrapped = winner{
                AddPlannerView(restaurant: unwrapped, show: $show)
                    .presentationDetents([.medium,.large])
            }
        })
        
    }
}

#Preview {
    TopOrBottomView().environmentObject(RestoViewModel())
}
