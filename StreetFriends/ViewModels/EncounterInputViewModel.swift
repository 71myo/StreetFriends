//
//  EncounterInputViewModel.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/31/25.
//

import Foundation
import Observation

enum EncounterTarget {
    case newCat(name: String)
    case existingCat(Cat)
}

@Observable
final class EncounterInputViewModel {
    // 입력 상태
    var note: String = ""
    var date: Date = .now
    var photoData: Data? = nil
    
    // UI 상태
    var isSaving: Bool = false
    
    // 사진 + 노트 필수
    var canSave: Bool {
        let hasPhoto = (photoData != nil)
        let hasNote = !note.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        return hasPhoto && hasNote
    }

    // 저장 타깃
    let target: EncounterTarget
    init(target: EncounterTarget) { self.target = target }
    
    // 네비게이션바 타이틀에 사용
    var title: String {
        switch target {
        case .newCat(let name):
            return name
        case .existingCat(let cat):
            return cat.name
        }
    }
    
    @MainActor
    func saveNewCatEncounter(using repo: CatRepository) -> Bool {
        guard let photoData, canSave else { return false }
        isSaving = true
        defer { isSaving = false }
        
        do {
            switch target {
            case .newCat(let name):
                _ = try repo.createCatWithFirstEncounter(name: name, date: date, note: note, photoData: photoData)
                
            case .existingCat(let cat):
                try repo.addEncounter(to: cat, date: date, note: note, photoData: photoData)
            }
            return true
        } catch {
            print("저장 실패: \(error)")
            return false
        }
    }
}
