//
//  RestoRecoApp.swift
//  RestoReco
//
//  Created by Aljonn Santos on 2/5/2024.
//

import SwiftUI

@main
struct RestoRecoApp: App {
    @StateObject var restoViewModel = RestoViewModel()
    var body: some Scene {
        WindowGroup {
            MenuView().environmentObject(restoViewModel)
        }
    }
}
