//
//  CatDetailViewModel.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/6/25.
//

import Foundation
import Observation

@Observable
final class CatDetailViewModel {
    var cat: Cat
    var isWorking: Bool = false
    var error: String?
    
    init(cat: Cat) {
        self.cat = cat
    }
    
    @MainActor
    func togggleFavorite(using repo: CatRepository) {
        guard !isWorking else { return }
        isWorking = true
        defer { isWorking = false }
        
        do {
            try repo.setFavorite(cat, isFavorite: !cat.isFavorite)
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    @MainActor
    func delete(repo: CatRepository) {
        do {
            try repo.deleteCat(cat)
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    func makeEditorViewModel() -> CatDetailEditViewModel {
        .init(cat: cat)
    }
}
