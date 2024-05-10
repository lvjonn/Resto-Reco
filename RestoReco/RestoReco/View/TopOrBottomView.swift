//
//  TopOrBottomView.swift
//  RestoReco
//
//  Created by Aljonn Santos on 6/5/2024.
//

import SwiftUI

struct TopOrBottomView: View {
    @EnvironmentObject var restoViewModel: RestoViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button(action: {print("top")}){
                HStack(spacing: 20) {
                    Spacer()
                    AsyncImage(url: URL(string: restoViewModel.optionOne?.imageUrl ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
                    
                    VStack(alignment: .leading){
                        Text(restoViewModel.optionOne?.name ?? "")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text("Rating: \(String(format: "%.1f", restoViewModel.optionOne?.rating ?? ""))")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                        Text("Reviews: \(restoViewModel.optionOne?.reviewCount ?? 0)")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                        Text("Price: \(restoViewModel.optionOne?.price ?? "N/A")")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
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
            
            Button(action: {print("bottom")}){
                HStack(spacing: 20) {
                    Spacer()
                    AsyncImage(url: URL(string: restoViewModel.optionTwo?.imageUrl ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
                    
                    VStack(alignment: .leading){
                        Text(restoViewModel.optionTwo?.name ?? "")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text("Rating: \(String(format: "%.1f", restoViewModel.optionTwo?.rating ?? ""))")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                        Text("Reviews: \(restoViewModel.optionTwo?.reviewCount ?? 0)")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                        Text("Price: \(restoViewModel.optionTwo?.price ?? "N/A")")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                }
            }
            .padding()
        }
        .padding(.vertical, 8)

    }
}

#Preview {
    TopOrBottomView().environmentObject(RestoViewModel())
}
