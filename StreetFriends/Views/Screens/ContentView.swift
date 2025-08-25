//
//  ContentView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/13/25.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTY
    @State private var isLaunch: Bool = true
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            if isLaunch {
                LaunchView()
                    .transition(.opacity)
            } else {
                HomeView()
                    .transition(.opacity)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.isLaunch = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
