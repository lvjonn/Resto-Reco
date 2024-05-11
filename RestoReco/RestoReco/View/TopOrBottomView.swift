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
    
    var body: some View {
        NavigationStack{
            VStack{
                if choiceCount < 5{
                    VStack(alignment: .leading, spacing: 8) {
                        Button(action: {
                            choiceCount += 1
                            topOrBottom = "top"
                            restoViewModel.changeOptionTwo()
                        }){
                            if let unwrapped = restoViewModel.optionOne{
                                RestaurantOverview(restaurant: unwrapped)
                            }
                            
                        }
                        .padding()
                        
                        HStack{
                            Spacer()
                            Image(systemName: "arrow.up.arrow.down.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 50, maxHeight: 50)
                                .foregroundColor(.red)
                                .foregroundStyle(.tint)
                                .padding(.bottom)
                            Spacer()
                        }
                        .padding(20)
                        
                        Button(action: {
                            choiceCount += 1
                            topOrBottom = "bottom"
                            restoViewModel.changeOptionOne()
                        }){
                            if let unwrapped = restoViewModel.optionTwo{
                                RestaurantOverview(restaurant: unwrapped)
                            }
                        }
                        .padding()
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
                        if topOrBottom == "top"{
                            if let unwrapped = restoViewModel.optionOne{
                                NavigationLink(destination: RestaurantDetailsView(restaurant: unwrapped)){
                                    RestaurantOverview(restaurant: unwrapped)
                                        .padding()
                                }
                            }
                        }else{
                            if let unwrapped = restoViewModel.optionTwo{
                                NavigationLink(destination: RestaurantDetailsView(restaurant: unwrapped)){
                                    RestaurantOverview(restaurant: unwrapped)
                                        .padding()
                                }
                            }
                        }
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
        
    }
}

#Preview {
    TopOrBottomView().environmentObject(RestoViewModel())
}
