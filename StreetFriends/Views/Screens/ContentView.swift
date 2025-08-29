//
//  ContentView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/13/25.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTY
    @State private var router = Router()
    @State private var isLaunch: Bool = true
    
    // MARK: - BODY
    var body: some View {
        if isLaunch {
            LaunchView()
                .transition(.opacity)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            self.isLaunch = false
                        }
                    }
                }
        } else {
            NavigationStack(path: $router.path) {
                HomeView()
                    .transition(.opacity)
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .addCatChoice: AddCatChoiceView()
                        case .catNameInput: CatNameInputView()
                        case .encounterInput(let name): EncounterInputView(catName: name)
                        }
                    }
            }
            .environment(router)
        }
    }
}

#Preview {
    ContentView()
}
