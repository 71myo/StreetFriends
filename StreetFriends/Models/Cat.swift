//
//  Cat.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/21/25.
//

import Foundation
import SwiftData

@Model
final class Cat {
    @Attribute(.unique) var id: UUID  = UUID()
    
    var name: String
    var creationDate: Date // 정렬용
    
    var isFavotite: Bool
    
    var representativeEncounter: Encounter? // 대표 Encounter(대표 사진 선택용)
    
    @Relationship(deleteRule: .cascade, inverse: \Encounter.cat)
    var encounters: [Encounter] = []
    
    var representativePhoto: Data? {
        representativeEncounter?.photo
    }
    
    init(name: String) {
        self.name = name
        self.creationDate = Date()
        self.isFavotite = false
    }
}
