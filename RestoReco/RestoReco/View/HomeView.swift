//
//  HomeView.swift
//  RestoReco
//
//  Created by Aljonn Santos on 10/5/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var restoViewModel: RestoViewModel
    @State private var activeTab: Tab = .restaurants
    @Namespace private var animation
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        VStack(spacing: 0){
            TabView(selection: $activeTab){
                MenuView()
                    .tag(Tab.restaurants)
                PlannerView()
                    .tag(Tab.planner)
                ShuffleView()
                    .tag(Tab.shuffle)
                TopOrBottomView()
                    .tag(Tab.toporbottom)
            }
            TabBar()
        }
    }
    @ViewBuilder
    func TabBar(_ color: Color = .red, _ inactiveColor: Color = .red) -> some View{
        HStack(alignment: .bottom, spacing: 0){
            ForEach(Tab.allCases, id: \.rawValue){
                TabItem(color: color, inactiveColor: inactiveColor, tab: $0, activeTab: $activeTab, animation: animation)
            }
        }
        .padding(.horizontal, 15)
        .background(content:{
            Rectangle()
                .fill(.white)
                .ignoresSafeArea()
                .shadow(color: color.opacity(0.2), radius: 5, x: 0, y: -5)
                .blur(radius: 2)
                .padding(.top, 15)
        })
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activeTab)
    }
}

struct TabItem: View{
    var color: Color
    var inactiveColor: Color
    var tab: Tab
    @Binding var activeTab: Tab
    var animation: Namespace.ID
    
    var body: some View{
        VStack{
            Image(systemName: tab.systemImage)
                .font(.title2)
                .foregroundColor(activeTab == tab ? .white : inactiveColor)
                .frame(width: activeTab == tab ? 58 : 35, height: activeTab == tab ? 58 : 35)
                .background{
                    if activeTab == tab {
                        Circle()
                            .fill(color.gradient)
                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                }
            Text(tab.rawValue)
                .font(.caption)
                .foregroundColor(activeTab == tab ? color : .gray)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            activeTab = tab
        }
    }
    
}



#Preview {
    HomeView().environmentObject(RestoViewModel())
}
