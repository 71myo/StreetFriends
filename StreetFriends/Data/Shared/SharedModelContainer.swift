//
//  SharedModelContainer.swift
//  StreetFriends
//
//  Created by Hyojeong on 12/23/25.
//

import Foundation
import SwiftData

enum SharedModelContainer {
    static let appGroupID = "group.hyojeong.StreetFriends"
    static let schema = Schema([Cat.self, Encounter.self])
    static var container: ModelContainer = {
        do {
            guard let groupURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupID)
            else {
                fatalError("App Group containerURL 생성 실패: \(appGroupID)")
            }
            // SwiftData 저장 파일 위치를 App Group 내부로 고정
            let storeURL = groupURL.appendingPathComponent("StreetFriends.store")
            let config = ModelConfiguration(schema: schema, url: storeURL)
            return try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("ModelContainer 생성 실패: \(error)")
        }
    }()
}
