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
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(SharedModelContainer.container)
    }
}
