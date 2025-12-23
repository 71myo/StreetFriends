//
//  SwiftDataCatRepository.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/31/25.
//

import Foundation
import SwiftData
import WidgetKit

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
        WidgetCenter.shared.reloadAllTimelines()
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
        WidgetCenter.shared.reloadAllTimelines()
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
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func updateCat(_ cat: Cat, name: String, firstMetDate: Date, profilePhoto: Data) throws {
        cat.name = name
        cat.firstMetDate = firstMetDate
        cat.profilePhoto = profilePhoto
        try context.save()
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func fetchEncounter(id: UUID) throws -> Encounter? {
        let descriptor = FetchDescriptor<Encounter>(predicate: #Predicate { $0.id == id })
        return try context.fetch(descriptor).first
    }
    
    func deleteEncounter(id: UUID) throws {
        let descriptor = FetchDescriptor<Encounter>(predicate: #Predicate { $0.id == id })
        if let encounter = try context.fetch(descriptor).first {
            context.delete(encounter)
            try context.save()
        }
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func updateEncounter(id: UUID, date: Date, note: String, photo: Data) throws {
        guard let encounter = try fetchEncounter(id: id) else { return }
        encounter.date = date
        encounter.note = note
        encounter.photo = photo
        try context.save()
        WidgetCenter.shared.reloadAllTimelines()
        print("App storeURL:", SharedModelContainer.storeURL.path) // 지울거
        print(SharedModelContainer.storeURLDebug()) // 지울거
    }
}
