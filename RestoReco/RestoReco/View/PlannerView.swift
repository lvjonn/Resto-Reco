//
//  PlannerView.swift
//  RestoReco
//
//  Created by Aljonn Santos on 6/5/2024.
//

import SwiftUI

struct PlannerView: View {
    @EnvironmentObject var restoViewModel: RestoViewModel
    @State var index = 0 //index for planned or history view
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        NavigationStack{
            VStack{
                HStack(spacing: 0){
                    Spacer(minLength: 0)
                    Text("Planned")
                        .foregroundColor(self.index == 0 ? .white : Color(.gray))
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                        .padding(.horizontal,35)
                        .background(Color(.red).opacity(self.index == 0 ? 1 : 0))
                        .clipShape(Capsule())
                        .onTapGesture {
                            withAnimation(.default){
                                self.index = 0
                            }
                        }
                    Spacer(minLength: 0)
                    
                    Text("History")
                        .foregroundColor(self.index == 1 ? .white : Color(.gray))
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                        .padding(.horizontal,35)
                        .background(Color(.red).opacity(self.index == 1 ? 1 : 0))
                        .clipShape(Capsule())
                        .onTapGesture {
                            withAnimation(.default){
                                self.index = 1
                            }
                        }
                    Spacer(minLength: 0)
                    
                    
                }
                .background(Color.black.opacity(0.03))
                .clipShape(Capsule())
                .padding(.horizontal, 55)
                .padding(.top, 25)
                
                
                TabView (selection: self.$index){
                    List(restoViewModel.plannedPlanner().sorted { $0.date > $1.date }) { restaurant in
                        Text("\(restaurant.date.formatted(date: .abbreviated, time: .omitted))")
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                            .padding(.vertical, 5)
                            .padding(.horizontal,15)
                            .background(Color.orange.opacity(0.1))
                            .clipShape(Capsule())
                        NavigationLink(destination: PlannerDetailsView(planner: restaurant)){
                            RestaurantOverview(restaurant: restaurant.restaurant)
                        }
                    }
                    .listStyle(.plain)
                    .tag(0)
                    
                    List(restoViewModel.historyPlanner().sorted { $0.date > $1.date }){ restaurant in
                        Text("\(restaurant.date.formatted(date:.abbreviated, time: .omitted))")
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                            .padding(.vertical, 5)
                            .padding(.horizontal,15)
                            .background(Color(Color.orange).opacity(0.1))
                            .clipShape(Capsule())
                        NavigationLink(destination: PlannerDetailsView(planner: restaurant)){
                            RestaurantOverview(restaurant: restaurant.restaurant)
                        }
                    }
                    .listStyle(.plain)
                    .tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                Spacer(minLength: 0)
            }
        }
    }
}

#Preview {
    PlannerView().environmentObject(RestoViewModel())
}
