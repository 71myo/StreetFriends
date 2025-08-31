//
//  EncounterInputViewModel.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/31/25.
//

import Foundation
import Observation

@Observable
final class EncounterInputViewModel {
    // 입력 상태
    var name: String = ""
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

    
    @MainActor
    func saveNewCatEncounter(using repo: CatRepository) -> Bool {
        guard let photoData else { return false }
        isSaving = true
        defer { isSaving = false }
        
        do {
            _ = try repo.createCatWithFirstEncounter(name: name, date: date, note: note, photoData: photoData)
            return true
        } catch {
            print("저장 실패: \(error)")
            return false
        }
    }
}
