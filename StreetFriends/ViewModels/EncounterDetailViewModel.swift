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
    
    // STATE
    var isLoading: Bool = false
    var error: String?
    
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
        } catch {
            self.error = error.localizedDescription
        }
    }
}
