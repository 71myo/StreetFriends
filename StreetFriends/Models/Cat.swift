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
    var firstMetDate: Date // 첫만남(사용자가 수정 가능, 수정해도 Encounter.date는 수정 안 됨)
    var creationDate: Date // 등록 시각(정렬용)
    var isFavotite: Bool
    
    // 최초 생성 시 첫 Encounter.photo로 저장, 이후 사용자가 교체 가능
    @Attribute(.externalStorage)
    var profilePhoto: Data
    
    @Relationship(deleteRule: .cascade, inverse: \Encounter.cat)
    var encounters: [Encounter] = []

    init(name: String, firstMetDate: Date, profilePhoto: Data) {
        self.name = name
        self.firstMetDate = firstMetDate
        self.creationDate = Date()
        self.isFavotite = false
        self.profilePhoto = profilePhoto
    }
    
    convenience init(name: String, firstEncounter: Encounter) {
        self.init(
            name: name,
            firstMetDate: firstEncounter.date,
            profilePhoto: firstEncounter.photo
        )
        addEncounter(firstEncounter)
    }
    
    // MARK: - FUNCTION
    func addEncounter(_ encounter: Encounter) {
        // 새 Encounter의 cat을 현재 Cat(self)로 연결
        encounter.cat = self
        
        // 현재 Cat의 encounters 배열에도 이 Encounter를 추가
        encounters.append(encounter)
    }
}
