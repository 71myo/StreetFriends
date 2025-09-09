//
//  CatRepository.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/31/25.
//

import Foundation

protocol CatRepository {
    @discardableResult // 리턴 안 써도 되도록 허용
    // 새로운 고양이, Encounter 생성
    func createCatWithFirstEncounter(
        name: String,
        date: Date,
        note: String,
        photoData: Data
    ) throws -> Cat
    
    // 기존 고양이에 Encounter 추가
    func addEncounter(
        to cat: Cat,
        date: Date,
        note: String,
        photoData: Data
    ) throws
    
    // 전체 고양이 불러오기
    func fetchAllCats() throws -> [Cat]
    
    // 고양이에 좋아요 기능
    func setFavorite(_ cat: Cat, isFavorite: Bool) throws
    
    // 좋아요한 고양이 불러오기
    func fetchFavoriteCats() throws -> [Cat]
    
    // 고양이 삭제
    func deleteCat(_ cat: Cat) throws
    
    // 고양이 수정 저장
    func updateCat(_ cat: Cat, name: String, firstMetDate: Date, profilePhoto: Data) throws
}
