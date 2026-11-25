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
    var id: UUID = UUID()
    
    var date: Date = Date.now
    var note: String = "" // 만남 일지
    @Attribute(.externalStorage) var photo: Data = Data()
    var cat: Cat?
    
    init(date: Date, note: String, photo: Data, cat: Cat? = nil) {
        self.date = date
        self.note = note
        self.photo = photo
        self.cat = cat
    }
}
