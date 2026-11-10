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
        let normalized = Cat.normalizedName(name)
        guard try !catNames(excluding: nil).contains(normalized) else {
            throw CatRepositoryError.duplicateName
        }
        
        let cat = Cat(name: normalized)
        let encounter = Encounter(date: date, note: note, photo: photoData)
        cat.addEncounter(encounter)
        context.insert(cat)
        try context.save()
        WidgetCenter.shared.reloadAllTimelines()
        rescheduleAnniversaries()
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
        rescheduleAnniversaries()
    }
    
    func updateCat(_ cat: Cat, name: String, firstMetDate: Date, profilePhoto: Data) throws {
        let normalized = Cat.normalizedName(name)
        guard try !catNames(excluding: cat.id).contains(normalized) else {
            throw CatRepositoryError.duplicateName
        }
        cat.name = normalized
        cat.firstMetDate = firstMetDate
        cat.profilePhoto = profilePhoto
        try context.save()
        WidgetCenter.shared.reloadAllTimelines()
        rescheduleAnniversaries()
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
    }
    
    // Notification
    private func rescheduleAnniversaries() {
        AnniversaryNotificationScheduler.reschedule(cats: (try? fetchAllCats()) ?? [])
    }
    
    func fetchCat(id: UUID) throws -> Cat? {
        let descriptor = FetchDescriptor<Cat>(predicate: #Predicate { $0.id == id })
        return try context.fetch(descriptor).first
    }
    
    func catNames(excluding catID: UUID?) throws -> Set<String> {
        var descriptor = FetchDescriptor<Cat>()
        descriptor.propertiesToFetch = [\.id, \.name]
        let cats = try context.fetch(descriptor)
        return Set(cats.filter { $0.id != catID }.map(\.name))
    }
}
