//
//  Encounter.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/21/25.
//

import Foundation
import SwiftData

@Model
final class Encounter: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    
    var date: Date
    var note: String // 만남 일지
    
    @Attribute(.externalStorage)
    var photo: Data
    
    var cat: Cat?
    
    init(date: Date, note: String, photo: Data) {
        self.date = date
        self.note = note
        self.photo = photo
    }
}
