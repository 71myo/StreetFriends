//
//  CatRepositoryKey.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/31/25.
//

import SwiftUI

private struct CatRepositoryKey: EnvironmentKey {
    static var defaultValue: CatRepository = DevNullCatRepository()
}

private struct DevNullCatRepository: CatRepository {
    func createCatWithFirstEncounter(name: String, date: Date, note: String, photoData: Data) throws -> Cat {
        fatalError("CatRepository not injected")
    }
    
    func addEncounter(to cat: Cat, date: Date, note: String, photoData: Data) throws {
        fatalError( "CatRepository not injected")
    }
    
    func fetchFavoriteCats() throws -> [Cat] {
        fatalError( "CatRepository not injected")
    }
    
    func fetchAllCats() throws -> [Cat] {
        fatalError( "CatRepository not injected")
    }
    
    func setFavorite(_ cat: Cat, isFavorite: Bool) throws {
        fatalError( "CatRepository not injected")
    }
    
    func deleteCat(_ cat: Cat) throws {
        fatalError( "CatRepository not injected")
    }
    
    func updateCat(_ cat: Cat, name: String, firstMetDate: Date, profilePhoto: Data) throws {
        fatalError( "CatRepository not injected")
    }
    
    func fetchEncounter(id: UUID) throws -> Encounter? {
        fatalError( "CatRepository not injected")
    }
    
    func deleteEncounter(id: UUID) throws {
        fatalError( "CatRepository not injected")
    }
}

extension EnvironmentValues {
    var catRepository: CatRepository {
        get {
            self[CatRepositoryKey.self]
        } set {
            self[CatRepositoryKey.self] = newValue
        }
    }
}
