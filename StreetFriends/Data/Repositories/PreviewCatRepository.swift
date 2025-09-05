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
    
    static func daysAgo(_ d: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: -d, to: .now) ?? .now
    }
    
    static var sampleCats: [Cat] {
        let c1 = Cat(name: "찐빵이", isFavorite: true)
        c1.profilePhoto = thumb("JJ", .orange)
        
        let c2 = Cat(name: "탄빵이", isFavorite: false)
        c2.profilePhoto = thumb("TB", .indigo)
        
        let c3 = Cat(name: "호빵이", isFavorite: true)
        c3.profilePhoto = thumb("HB", .brown)
        
        // 찐빵이
        c1.addEncounter(Encounter(
            date: daysAgo(7),
            note: """
            철길 지나가다가 만난 치즈고양이
            원래 있던 친구가 입양가고 새로운 친구가 왔다!
            얼굴이 뭔가 빵실해서 찐빵이라고 부르기로 했다
                            
            처음 만났는데 멋있는 자세로 그루밍을 하는 모습ㅋㅋ
            사람을 경계하진 않는데 그렇다고 만지면 또 자리를 피한다
            """,
            photo: thumb("JJ-1", .orange)
        ))
        c1.addEncounter(Encounter(
            date: daysAgo(3),
            note: "익숙해졌는지 근처를 서성거리며 애교를 보였다.",
            photo: thumb("JJ-2", .teal)
        ))
        c1.addEncounter(Encounter(
            date: daysAgo(1),
            note: "오늘은 츄르를 받아먹었다!",
            photo: thumb("JJ-3", .yellow)
        ))
        
        // 탄빵이
        c2.addEncounter(Encounter(
            date: daysAgo(5),
            note: "멀리서 지켜보던 올블랙 친구. 아직 거리유지 모드.",
            photo: thumb("TB-1", .indigo)
        ))
        c2.addEncounter(Encounter(
            date: daysAgo(2),
            note: "조금 더 가까이 와서 냄새를 맡았다. 진전!",
            photo: thumb("TB-2", .pink)
        ))
        
        // 호빵이
        c3.addEncounter(Encounter(
            date: daysAgo(10),
            note: "골목 모퉁이에서 처음 인사. 사람을 좋아하는 느낌.",
            photo: thumb("HB-1", .brown)
        ))
        c3.addEncounter(Encounter(
            date: daysAgo(4),
            note: "나를 보자 꼬리를 세우며 다가왔다. 손길 허용!",
            photo: thumb("HB-2", .green)
        ))
        
        return [c1, c2, c3]
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
    static var previewThree: Cat { PreviewFixtures.sampleCats[2] }
}
#endif
