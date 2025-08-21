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
    var creationDate: Date
    
    @Relationship(deleteRule: .cascade, inverse: \Encounter.cat)
    var encounters: [Encounter] = []
    
    init(name: String) {
        self.name = name
        self.creationDate = Date()
    }
}
