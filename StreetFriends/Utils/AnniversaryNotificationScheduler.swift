//
//  AnniversaryNotificationScheduler.swift
//  StreetFriends
//
//  Created by kimhyojeong on 11/4/26.
//

import Foundation
import UserNotifications

enum AnniversaryNotificationScheduler {
    private static let center = UNUserNotificationCenter.current()
    private static let idPrefix = "anniversary"
    private static let maxCount = 60 // iOS 한도 64개 중 여유분
    private static let fireHour = 10 // 오전 10시
    private static let calendar = Calendar(identifier: .gregorian) // 기기 달력 설정과 무관하게 양력 기준
    
    // 예약에 필요한 값만 담은 구조체
    struct Item: Sendable {
        let catID: UUID
        let name: String
        let years: Int
        let fireDate: Date
    }
    
    // MARK: -  외부에서 쓰는 함수
    /// 첫 고양이 등록 직후 호출: 권한 요청 -> 예약
    static func requestAuthorizationAndReschedule(cats: [Cat]) {
        let items = makeItems(from: cats)
        Task {
            _ = try? await center.requestAuthorization(options: [.alert, .sound])
            await schedule(items)
        }
    }

    /// 데이터 변경, 앱 활성화 시 호출: 전부 지우고 다시 예약
    static func reschedule(cats: [Cat]) {
        let items = makeItems(from: cats)
        Task { await schedule(items) }
    }
    
    
    // MARK: - 계산
    static func makeItems(from cats: [Cat], now: Date = .now) -> [Item] {
        cats.compactMap { nextAnniversary(of: $0, after: now) }
            .sorted { $0.fireDate < $1.fireDate }
            .prefix(maxCount)
            .map { $0 }
    }

    private static func nextAnniversary(of cat: Cat, after now: Date) -> Item? {
        guard let firstMet = cat.firstMetDate else { return nil }
        let start = calendar.startOfDay(for: firstMet)
        let passed = max(1, calendar.dateComponents([.year], from: start, to: now).year ?? 0)

        // 원래 첫만남 날짜 + n년 (2/29 -> 평년엔 2/28, 윤년엔 2/29 자동 처리)
        for years in passed...(passed + 1) {
            guard let day = calendar.date(byAdding: .year, value: years, to: start),
                  let fireDate = calendar.date(bySettingHour: fireHour, minute: 0, second: 0, of: day),
                  fireDate > now else { continue }   // 오늘 10시가 지났으면 내년으로
            return Item(catID: cat.id, name: cat.name, years: years, fireDate: fireDate)
        }
        return nil
    }
    
    // MARK: - 예약
    private static func schedule(_ items: [Item]) async {
        let settings = await center.notificationSettings()
        guard settings.authorizationStatus == .authorized else { return } // 거절/미결정이면 조용히 종료

        let pending = await center.pendingNotificationRequests()
        let oldIDs = pending.map(\.identifier).filter { $0.hasPrefix(idPrefix) }
        center.removePendingNotificationRequests(withIdentifiers: oldIDs)

        for item in items {
            try? await center.add(makeRequest(for: item))
        }
    }

    private static func makeRequest(for item: Item) -> UNNotificationRequest {
        let content = UNMutableNotificationContent()
        content.title = "\(item.name)\(item.name.eulReul) 만난 지 \(item.years)년이 되었어요! 🎉"
        content.body = "그동안 함께한 추억을 돌아볼까요? 🐾"
        content.sound = .default
        content.userInfo = ["catID": item.catID.uuidString]   // 탭하면 상세 화면 이동용

        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: item.fireDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)

        return UNNotificationRequest(identifier: idPrefix + item.catID.uuidString,
                                     content: content, trigger: trigger)
    }
}
