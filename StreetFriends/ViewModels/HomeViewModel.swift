//
//  HomeViewModel.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/1/25.
//

import Foundation
import Observation

@Observable
final class HomeViewModel {
    // 입력 UI 상태
    var searchText: String = ""
    var isSearching: Bool = false
    
    // 데이터 상태
    var favorites: [Cat] = []
    var allCats: [Cat] = []
    var isLoading: Bool = false
    var error: String?
    var isEmptyState: Bool {
        allCats.isEmpty
    }
    
    // 검색 관련
    var trimmedText: String { searchText.trimmingCharacters(in: .whitespacesAndNewlines) }

    var filteredCats: [Cat] {
        let q = trimmedText.searchFolded
        guard !q.isEmpty else { return [] }
        return allCats.filter { $0.name.searchFolded.contains(q) }
    }
    
    // 한달 동안 가장 많이 만난 고양이
    var mostMetCat: Cat? {
        allCats.max { $0.encounters.count < $1.encounters.count }
    }
    
    var mostMetCount: Int {
        mostMetCat?.encounters.count ?? 0
    }
    
    @MainActor
    func load(repo: CatRepository) {
        isLoading = true
        defer {
            isLoading = false
        }
        
        do {
            favorites = try repo.fetchFavoriteCats()
            allCats = try repo.fetchAllCats()
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    @MainActor
    func toggleFavorite(cat: Cat, repo: CatRepository) {
        do {
            try repo.setFavorite(cat, isFavorite: !cat.isFavorite)
            load(repo: repo)
        } catch {
            self.error = error.localizedDescription
        }
    }
}
