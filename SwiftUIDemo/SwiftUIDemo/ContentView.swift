//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by Anurag Chourasia on 08/02/26.
//

import SwiftUI

struct ContentView: View {

    // MARK: - Body
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                WorkshopHubView()
            }
        } else {
            NavigationView {
                WorkshopHubView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

#Preview {
    ContentView()
}
