//
//  EncounterDetailViewModel.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/19/25.
//

import Foundation
import Observation

@Observable
final class EncounterDetailViewModel {
    private let encounterID: UUID
    
    // UI PROPERTIES
    var dateText: String = ""
    var note: String = ""
    var photoData: Data = Data()
    var catName: String = ""
    var isFavorite: Bool = false
    
    // STATE
    var isLoading: Bool = false
    var error: String?
    var shouldDismiss: Bool = false // 삭제 후 화면 닫기
    
    init(encounterID: UUID) {
        self.encounterID = encounterID
    }
    
    @MainActor
    func load(using repo: CatRepository) {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {
            guard let encounter = try repo.fetchEncounter(id: encounterID) else {
                error = "만남 정보를 찾을 수 없습니다."
                return
            }
            
            note = encounter.note
            photoData = encounter.photo
            dateText = encounter.date.formattedDot
            catName = encounter.cat?.name ?? ""
            isFavorite = encounter.cat?.isFavorite ?? false
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    @MainActor
    func toggleFavorite(using repo: CatRepository) {
        do {
            guard let encounter = try repo.fetchEncounter(id: encounterID),
                  let cat = encounter.cat else { return }
            try repo.setFavorite(cat, isFavorite: !cat.isFavorite)
            isFavorite.toggle()
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    @MainActor
    func deleteEncounter(using repo: CatRepository) {
        do {
            try repo.deleteEncounter(id: encounterID)
            shouldDismiss = true
        } catch {
            self.error = error.localizedDescription
        }
    }
}
