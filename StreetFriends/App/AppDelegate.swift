//
//  AppDelegate.swift
//  StreetFriends
//
//  Created by kimhyojeong on 11/5/26.
//

import UIKit
import UserNotifications

final class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication,
                         didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
            UNUserNotificationCenter.current().delegate = self
            return true
        }

        // 앱 사용 중에도 배너 표시
        func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
            [.banner, .list, .sound]
        }

        // 알림 탭
        func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    didReceive response: UNNotificationResponse) async {
            guard let idString = response.notification.request.content.userInfo["catID"] as? String,
                  let catID = UUID(uuidString: idString) else { return }
            await MainActor.run { DeepLinkStore.shared.pendingCatID = catID }
        }
}
