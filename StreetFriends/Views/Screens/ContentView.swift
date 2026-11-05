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
    @Environment(\.scenePhase) private var scenePhase
    @State private var router = Router()
    @State private var isLaunch: Bool = true
    @State private var deepLink = DeepLinkStore.shared
    
    // MARK: - BODY
    var body: some View {
        if isLaunch {
            LaunchView()
                .transition(.opacity)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
                        case .encounterInput(let name): EncounterInputView(newCatName: name)
                        case .catDetail(let catID):
                            if let cat = try? SwiftDataCatRepository(context: modelContext).fetchCat(id: catID) {
                                CatDetailView(cat: cat)
                            }
                        }
                    }
            }
            .environment(\.catRepository, SwiftDataCatRepository(context: modelContext))
            .environment(router)
            .onChange(of: scenePhase, initial: true) { _, phase in
                guard phase == .active else { return }
                let repo = SwiftDataCatRepository(context: modelContext)
                AnniversaryNotificationScheduler.reschedule(cats: (try? repo.fetchAllCats()) ?? [])
            }
            .onChange(of: deepLink.pendingCatID, initial: true) { _, catID in
                guard let catID else { return }
                router.popToRoot()
                router.push(.catDetail(catID: catID))
                deepLink.pendingCatID = nil      // 한 번 처리했으면 비우기
            }
        }
    }
}

#Preview {
    ContentView()
}
