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
    var creationDate: Date // 등록 시각(정렬용)
    var firstMetDate: Date? // 첫만남(사용자가 수정 가능, 수정해도 Encounter.date는 수정 안 됨)
    var profilePhoto: Data? // 첫 Encounter.photo로 초기화
    var isFavorite: Bool
    
    @Relationship(deleteRule: .cascade, inverse: \Encounter.cat)
    var encounters: [Encounter] = []

    init(name: String,
         creationgDate: Date = .now,
         firstMetDate: Date? = nil,
         profilePhoto: Data? = nil,
         isFavorite: Bool = false) {
        self.name = name
        self.creationDate = Date()
        self.firstMetDate = firstMetDate
        self.profilePhoto = profilePhoto
        self.isFavorite = isFavorite
    }
    
    // MARK: - FUNCTION
    func addEncounter(_ encounter: Encounter) {
        encounters.append(encounter)
        encounter.cat = self
        
        if profilePhoto == nil { profilePhoto = encounter.photo }
        if firstMetDate == nil { firstMetDate = encounter.date }
    }
}
