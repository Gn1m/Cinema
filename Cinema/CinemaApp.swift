//
//  CinemaApp.swift
//  Cinema
//
//  Created by 1 on 3/5/2024.
//

// CinemaApp.swift
import SwiftUI

@main
struct CinemaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(OrderViewModel.shared) // Injecting the ViewModel
        }
    }
}
