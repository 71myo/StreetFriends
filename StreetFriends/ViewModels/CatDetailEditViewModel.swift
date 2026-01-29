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
    // MARK: - PROPERTIES
    private let cat: Cat
    
    // 수정할 데이터
    var name: String
    var firstMetDate: Date
    var profilePhotoData: Data
    var pickedPhotoData: Data?
    
    // UI 상태
    var isSaving: Bool = false
    var error: String?
    
    // NAVIGATION, ALERT
    var showDiscardAlert: Bool = false
    var shouldDismiss: Bool = false
    
    // 초기 스냅샷
    private let initialName: String
    private let initialFirstMetDate: Date
    private let initialProfilePhotoData: Data
    
    init(cat: Cat) {
        self.cat = cat
        
        // 초기 편집값 세팅
        let firstMetDate = cat.firstMetDate ?? cat.encounters.min(by: { $0.date < $1.date })?.date ?? .now
        let photo = cat.profilePhoto ?? cat.encounters.min(by: { $0.date < $1.date })?.photo ?? Data()
        
        self.name = cat.name
        self.firstMetDate = firstMetDate
        self.profilePhotoData = photo
        
        // 스냅샷 저장
        self.initialName = cat.name
        self.initialFirstMetDate = firstMetDate
        self.initialProfilePhotoData = photo
    }
    
    // 현재 사진(선택한 게 있으면 그거, 아니면 기존)
    var currentPhotoData: Data { pickedPhotoData ?? profilePhotoData }
        
    var canSave: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && hasUnsavedChanges
    }
    
    // 변경 여부
    var hasUnsavedChanges: Bool {
        let nameChanged = name.trimmingCharacters(in: .whitespacesAndNewlines) != initialName
        let dateChanged = firstMetDate != initialFirstMetDate
        let photoChanged = currentPhotoData != initialProfilePhotoData
        
        return nameChanged || dateChanged || photoChanged
    }
    
    // MARK: - Actions
    // 변경하고 뒤로가기 누르면 Alert, 변경 저장 후 뒤로가기 누르면 Dismiss
    @MainActor
    func onTapBack() {
        if hasUnsavedChanges {
            showDiscardAlert = true
        } else {
            shouldDismiss = true
        }
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
            try repo.updateCat(cat,
                               name: name.trimmingCharacters(in: .whitespacesAndNewlines),
                               firstMetDate: firstMetDate,
                               profilePhoto: currentPhotoData)
            return true
        } catch {
            self.error = error.localizedDescription
            return false
        }
    }
}
