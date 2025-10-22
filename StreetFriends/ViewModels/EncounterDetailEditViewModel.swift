//
//  EncounterDetailEditViewModel.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/30/25.
//

import Foundation
import Observation

@Observable
final class EncounterDetailEditViewModel {
    // MARK: - Properties
    // Identity
    let encounterID: UUID
    
    // Editable
    var catName: String = ""
    var note: String = ""
    var date: Date = .now
    var photoData: Data? = nil
    
    // Snapshot
    private var initialNote: String = ""
    private var initialDate: Date = .now
    private var initialPhotoData: Data = Data()
    private var snapshotInitialized = false
    
    // 현재 저장될 사진
    var currentPhotoData: Data { photoData ?? initialPhotoData }
    
    // UI States
    var isLoading: Bool = false
    var isSaving: Bool = false
    var error: String?
    var showDiscardAlert: Bool = false
    var shouldDismiss: Bool = false
    
    // 변경/저장 가능 여부
    var hasUnsavedChanges: Bool {
        (note != initialNote) || (date != initialDate) || (currentPhotoData != initialPhotoData)
    }
    
    var canSave: Bool {
        !note.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && hasUnsavedChanges
    }
    
    init(encounterID: UUID) {
        self.encounterID = encounterID
    }
    
    // MARK: - Actions
    @MainActor
    func load(using repo: CatRepository) {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {
            guard let enc = try repo.fetchEncounter(id: encounterID) else {
                error = "Could not find encounter."
                return
            }
            
            // UI 바인딩
            catName = enc.cat?.name ?? ""
            note = enc.note
            date = enc.date
            photoData = enc.photo
            
            // 스냅샷은 최초 로딩에만 고정
            if !snapshotInitialized {
                initialNote = enc.note
                initialDate = enc.date
                initialPhotoData = enc.photo
                snapshotInitialized = true
            }
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    // 변경하고 뒤로가기 누르면 Alert, 변경 저장 후 뒤로가기 누르면 Dismiss
    @MainActor
    func onTapBack() {
        hasUnsavedChanges ? (showDiscardAlert = true) : (shouldDismiss = true)
    }
    
    // Alert 수정하기 버튼 액션
    @MainActor
    func confirmSaveAndDismiss(using repo: CatRepository) {
        if save(using: repo) {
            showDiscardAlert = false
            shouldDismiss = true
        }
    }
    
    // Alert 뒤로가기 버튼 액션
    @MainActor
    func cancelDiscard() {
        showDiscardAlert = false
    }
    
    // 저장하기 버튼 액션
    @MainActor
    func onTapSave(using repo: CatRepository) {
        guard canSave else { return }
        if save(using: repo) {
            shouldDismiss = true
        }
    }
    
    private func save(using repo: CatRepository) -> Bool {
        guard canSave else { return false }
        isSaving = true
        defer { isSaving = false }
        
        do {
            try repo.updateEncounter(
                id: encounterID,
                date: date,
                note: note,
                photo: currentPhotoData
            )
            return true
        } catch {
            self.error = error.localizedDescription
            return false
        }
    }
}
