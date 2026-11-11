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
    var filteredCats: [Cat] {
        let trimmedText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        let q = trimmedText.searchFolded
        guard !q.isEmpty else { return [] }
        return allCats.filter { $0.name.searchFolded.contains(q) }
    }
    
    // 한 달 동안 가장 많이 만난 고양이 (load할 때 계산)
    private(set) var monthlyTopCat: MonthlyTopCat.Result?
    
    @MainActor
    func load(repo: CatRepository) {
        isLoading = true
        defer {
            isLoading = false
        }
        
        do {
            favorites = try repo.fetchFavoriteCats()
            allCats = try repo.fetchAllCats()
            monthlyTopCat = Self.topCatInThisMonth(from: allCats)
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
    
    private static func topCatInThisMonth(from cats: [Cat]) -> MonthlyTopCat.Result? {
        guard let month = MonthlyTopCat.monthInterval() else { return nil }
        return MonthlyTopCat.top(from: cats.flatMap(\.encounters), in: month)
    }
}
