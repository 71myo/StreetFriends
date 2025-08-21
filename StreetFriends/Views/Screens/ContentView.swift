//
//  ContentView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/13/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isLaunch: Bool = true
    
    var body: some View {
        ZStack {
            if isLaunch {
                LaunchView()
                    .transition(.opacity)
                
            } else {
                Text("HomeView")
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
