//
//  ContentView.swift
//  Cinema
//
//  Created by 1 on 3/5/2024.
//

// ContentView.swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Label("Movies", systemImage: "film")
                }

            OrdersView()
                .tabItem {
                    Label("Orders", systemImage: "cart")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

