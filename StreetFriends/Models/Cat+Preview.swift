//
//  Cat+Preview.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/21/25.
//

import Foundation
import SwiftData

extension Cat {
    @MainActor
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: Cat.self, Encounter.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        let jjinbbang = Cat(name: "찐빵이")
        let jjinbbangEncounter1 = Encounter(date: Date().addingTimeInterval(-500000),
                                            note: "철길 지나가다가 만난 치즈고양이. 원래 있던 친구가 입양가고 새로운 친구가 왔다! 얼굴이 뭔가 빵실해서 찐빵이라고 부르기로 했다",
                                            photo: nil)
        let jjinbbangEncounter2 = Encounter(date: Date().addingTimeInterval(-100000),
                                            note: "찐빵이를 어제 봤던 그 자리에서 또 만났다. 나를 알아보고 냅다 누워서 오늘은 츄르를 줬다.",
                                            photo: nil)
        
        let tanbbang = Cat(name: "탄빵이")
        let tanbbangEncounter1 = Encounter(date: Date(),
                                           note: "온몸이 까만 고양이. 경계심이 많아 가까이 다가가기는 어려웠다. 얘는 아직 사람 손을 덜 탔나보다.",
                                           photo: nil)
        
        jjinbbang.encounters = [jjinbbangEncounter1, jjinbbangEncounter2]
        tanbbang.encounters = [tanbbangEncounter1]
        
        container.mainContext.insert(jjinbbang)
        container.mainContext.insert(tanbbang)
        
        return container
    }
}
