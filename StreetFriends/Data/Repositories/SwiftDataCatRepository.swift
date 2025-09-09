//
//  SwiftDataCatRepository.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/31/25.
//

import Foundation
import SwiftData

final class SwiftDataCatRepository: CatRepository {
    private let context: ModelContext
    init(context: ModelContext) { self.context = context }
    
    @discardableResult
    func createCatWithFirstEncounter(
        name: String,
        date: Date,
        note: String,
        photoData: Data
    ) throws -> Cat {
        let cat = Cat(name: name)
        let encounter = Encounter(date: date, note: note, photo: photoData)
        cat.addEncounter(encounter)
        context.insert(cat)
        try context.save()
        return cat
    }
    
    func addEncounter(
        to cat: Cat,
        date: Date,
        note: String,
        photoData: Data
    ) throws {
        let encounter = Encounter(date: date, note: note, photo: photoData, cat: cat)
        cat.addEncounter(encounter)
        try context.save()
    }
    
    func fetchAllCats() throws -> [Cat] {
        let descriptor = FetchDescriptor<Cat>(
            sortBy: [SortDescriptor(\.creationDate, order: .reverse)]
        )
        return try context.fetch(descriptor)
    }
    
    func setFavorite(_ cat: Cat, isFavorite: Bool) throws {
        cat.isFavorite = isFavorite
        try context.save()
    }
    
    func fetchFavoriteCats() throws -> [Cat] {
        let descriptor = FetchDescriptor<Cat>(
            predicate: #Predicate { $0.isFavorite == true },
            sortBy: [SortDescriptor(\.creationDate, order: .reverse)]
        )
        return try context.fetch(descriptor)
    }
    
    func deleteCat(_ cat: Cat) throws {
        context.delete(cat)
        try context.save()
    }
    
    func updateCat(_ cat: Cat, name: String, firstMetDate: Date, profilePhoto: Data) throws {
        cat.name = name
        cat.firstMetDate = firstMetDate
        cat.profilePhoto = profilePhoto
        try context.save()
    }
}
