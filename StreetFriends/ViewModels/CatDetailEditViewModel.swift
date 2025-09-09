//
//  CatDetailEditViewModel.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/8/25.
//

import Foundation
import Observation

@Observable
final class CatDetailEditViewModel {
    private let cat: Cat
    
    // 수정할 데이터
    var name: String
    var firstMetDate: Date
    var profilePhotoData: Data
    
    var pickedPhotoData: Data?
    
    var isSaving: Bool = false
    var error: String?
    
    init(cat: Cat) {
        self.cat = cat
        self.name = cat.name
        self.firstMetDate = cat.firstMetDate ?? cat.encounters.min(by: { $0.date < $1.date })?.date ?? .now
        self.profilePhotoData = cat.profilePhoto ?? cat.encounters.min(by: { $0.date < $1.date })?.photo ?? Data()
    }
    
    var canSave: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    @MainActor
    func save(using repo: CatRepository) -> Bool {
        guard canSave else { return false }
        isSaving = true
        defer { isSaving = false }
        
        let finalPhoto = pickedPhotoData ?? profilePhotoData
        
        do {
            try repo.updateCat(cat,
                               name: name.trimmingCharacters(in: .whitespacesAndNewlines),
                               firstMetDate: firstMetDate,
                               profilePhoto: finalPhoto)
            return true
        } catch {
            self.error = error.localizedDescription
            return false
        }
    }
}
