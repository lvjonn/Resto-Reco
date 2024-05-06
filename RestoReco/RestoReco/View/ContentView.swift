//
//  ContentView.swift
//  RestoReco
//
//  Created by Aljonn Santos on 2/5/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "fork.knife")
                .foregroundColor(.black)
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("RestoReco")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
