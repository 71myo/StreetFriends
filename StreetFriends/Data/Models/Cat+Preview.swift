//
//  Cat+Preview.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/21/25.
//

#if DEBUG
import SwiftUI
import SwiftData

enum PreviewData {
    @MainActor
    static func container() -> ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Cat.self, Encounter.self, configurations: config)
        seed(into: container.mainContext)
        return container
    }

    @MainActor
    static func seed(into ctx: ModelContext) {
        func daysAgo(_ d: Int) -> Date {
            Calendar.current.date(byAdding: .day, value: -d, to: .now) ?? .now
        }

        func thumb(_ text: String, bg: Color) -> Data {
            let view = ZStack {
                bg
                Text(text)
                    .font(.system(size: 64, weight: .heavy))
                    .foregroundStyle(.white)
            }
            .frame(width: 200, height: 200)
            let r = ImageRenderer(content: view)
            #if os(iOS)
            return r.uiImage?.jpegData(compressionQuality: 0.85) ?? Data()
            #else
            return Data()
            #endif
        }

        // 샘플 1: 찐빵이
        let cat1 = Cat(name: "찐빵이", isFavorite: true)
        cat1.addEncounter(Encounter(
            date: daysAgo(6),
            note: "철길에서 처음 만남. 빵실해서 찐빵이!",
            photo: thumb("JJ", bg: .orange)
        ))
        cat1.addEncounter(Encounter(
            date: daysAgo(2),
            note: "어제 보던 자리에서 또 마주침. 오늘은 츄르!",
            photo: thumb("J2", bg: .teal)
        ))

        // 샘플 2: 탄빵이
        let cat2 = Cat(name: "탄빵이")
        cat2.addEncounter(Encounter(
            date: daysAgo(1),
            note: "올블랙, 경계심 많음.",
            photo: thumb("TB", bg: .indigo)
        ))
        cat2.addEncounter(Encounter(
            date: .now,
            note: "조금 더 가까이 와서 냄새 맡았다!",
            photo: thumb("T2", bg: .pink)
        ))

        ctx.insert(cat1)
        ctx.insert(cat2)
        try? ctx.save()
    }
}
#endif
