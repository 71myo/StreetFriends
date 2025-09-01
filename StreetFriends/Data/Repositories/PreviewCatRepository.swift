//
//  PreviewCatRepository.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/1/25.
//

#if DEBUG
import SwiftUI

// MARK: - Fixtures (Thumb 생성 + 샘플 Cat)
@MainActor
enum PreviewFixtures {
    static func thumb(_ text: String, _ color: Color) -> Data {
        let view = ZStack {
            color
            Text(text)
                .font(.system(size: 56, weight: .heavy))
                .foregroundStyle(.white)
        }
        .frame(width: 160, height: 160)

        let renderer = ImageRenderer(content: view)
        return renderer.uiImage?.jpegData(compressionQuality: 0.85) ?? Data()
    }

    static var sampleCats: [Cat] {
        let c1 = Cat(name: "찐빵이", isFavorite: true)
        c1.profilePhoto = thumb("JJ", .orange)

        let c2 = Cat(name: "탄빵이", isFavorite: false)
        c2.profilePhoto = thumb("TB", .indigo)

        return [c1, c2]
    }
}

// MARK: - 미니 목업 저장소 (CatRepository 구현, 메모리 기반)
final class PreviewCatRepository: CatRepository {
    private var cats: [Cat]

        init(cats: [Cat]) {
            self.cats = cats
        }
    
        @MainActor
        convenience init() {
            self.init(cats: PreviewFixtures.sampleCats)
        }

    // 새로운 고양이 + 첫 만남 생성
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
        cats.append(cat)
        return cat
    }

    // 기존 고양이에 만남 추가
    func addEncounter(
        to cat: Cat,
        date: Date,
        note: String,
        photoData: Data
    ) throws {
        let encounter = Encounter(date: date, note: note, photo: photoData, cat: cat)
        cat.addEncounter(encounter)
        // 프리뷰 저장소는 메모리 배열이라 따로 save 불필요
    }

    func fetchAllCats() throws -> [Cat] {
        cats.sorted { $0.creationDate > $1.creationDate }
    }

    func setFavorite(_ cat: Cat, isFavorite: Bool) throws {
        cat.isFavorite = isFavorite
    }

    func fetchFavoriteCats() throws -> [Cat] {
        cats.filter { $0.isFavorite }
            .sorted { $0.creationDate > $1.creationDate }
    }
}

// MARK: - 편의 확장 (원클릭 접근)
@MainActor
extension Cat {
    static var previewOne: Cat { PreviewFixtures.sampleCats[0] }
    static var previewTwo: Cat { PreviewFixtures.sampleCats[1] }
}
#endif
