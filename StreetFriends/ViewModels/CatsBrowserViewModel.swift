//
//  CatsBrowserViewModel.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/1/25.
//  AllCatsGridView, FavoriteCatsGridView, CatSelectView에 사용할 공용 VM

import Foundation
import Observation

enum CatsScope {
    case all // AllCatsGridView
    case favorites // FavoriteCatsGridView
    case both // CatSelectView
}

@Observable
final class CatsBrowserViewModel {
    // 화면 모드
    let scope: CatsScope
    
    // UI 상태
    var searchText: String = ""
    var isSearching: Bool = false
    
    // 데이터 상태
    var favorites: [Cat] = []
    var allCats: [Cat] = []
    var isLoading: Bool = false
    var error: String?
    
    init(scope: CatsScope) { self.scope = scope }
    
    // 검색 파생값
    var trimmedQuery: String { searchText.trimmingCharacters(in: .whitespacesAndNewlines) }
    var hasQuery: Bool { !trimmedQuery.isEmpty }
    
    private func normalized(_ s: String) -> String {
        s.replacingOccurrences(of: " ", with: "")
            .folding(options: [.caseInsensitive, .diacriticInsensitive], locale: .current)
    }
    
    // 뷰에서 보여줄 리스트
    var displayedCats: [Cat] {
        switch scope {
        case .all:
            return allCats
        case .favorites:
            return favorites
        case .both:
            return allCats
        }
    }
    
    // 검색 오버레이에 보여줄 결과 리스트
    var searchResults: [Cat] {
        guard hasQuery else { return [] }
        let q = normalized(trimmedQuery)
        switch scope {
        case .all, .both:
            return allCats.filter { normalized($0.name).contains(q) }
        case .favorites:
            return favorites.filter { normalized($0.name).contains(q) }
        }
    }
    
    // MARK: - Actions
    @MainActor
    func load(repo: CatRepository) {
        isLoading = true
        defer { isLoading = false }
        
        do {
            switch scope {
            case .all:
                allCats   = try repo.fetchAllCats()
                favorites = try repo.fetchFavoriteCats()
            case .favorites:
                favorites = try repo.fetchFavoriteCats()
            case .both:
                favorites = try repo.fetchFavoriteCats()
                allCats   = try repo.fetchAllCats()
            }
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
