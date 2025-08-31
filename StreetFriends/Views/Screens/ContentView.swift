//
//  ContentView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/13/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    // MARK: - PROPERTY
    @Environment(\.modelContext) private var modelContext
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
            .environment(\.catRepository, SwiftDataCatRepository(context: modelContext))
            .environment(router)
        }
    }
}

#Preview {
    ContentView()
}
