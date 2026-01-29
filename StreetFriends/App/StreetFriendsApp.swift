//
//  StreetFriendsApp.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/13/25.
//

import SwiftUI
import SwiftData

@main
struct StreetFriendsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(SharedModelContainer.container)
    }
}
