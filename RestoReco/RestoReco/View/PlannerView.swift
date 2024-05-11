//
//  PlannerView.swift
//  RestoReco
//
//  Created by Aljonn Santos on 6/5/2024.
//

import SwiftUI

struct PlannerView: View {
    @EnvironmentObject var restoViewModel: RestoViewModel
    @State var index = 0
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
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
                List(restoViewModel.planned){ restaurant in
                    RestaurantOverview(restaurant: restaurant)
                }
                .listStyle(.plain)
                .tag(0)
                
                List(restoViewModel.history){ restaurant in
                    RestaurantOverview(restaurant: restaurant)
                }
                .listStyle(.plain)
                .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

            Spacer(minLength: 0)
        }
    }
}

#Preview {
    PlannerView().environmentObject(RestoViewModel())
}
