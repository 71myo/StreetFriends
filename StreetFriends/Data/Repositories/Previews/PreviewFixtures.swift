//
//  PreviewFixtures.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/1/25.
//

//#if DEBUG
//import SwiftUI
//
//@MainActor
//enum PreviewFixtures {
//    static func thumb(_ text: String, _ color: Color) -> Data {
//        let v = ZStack {
//            color
//            Text(text)
//                .font(.system(size: 56, weight: .heavy))
//                .foregroundStyle(.white)
//        }
//        .frame(width: 160, height: 160)
//
//        let r = ImageRenderer(content: v)
//        return r.uiImage?.jpegData(compressionQuality: 0.85) ?? Data()
//    }
//
//    static var sampleCats: [Cat] {
//        let c1 = Cat(name: "찐빵이", isFavorite: true)
//        c1.profilePhoto = thumb("JJ", .orange)
//        c1.addEncounter(Encounter(date: .now, note: "샘플", photo: Data()))
//
//        let c2 = Cat(name: "탄빵이")
//        c2.profilePhoto = thumb("TB", .indigo)
//        c2.addEncounter(Encounter(date: .now, note: "샘플", photo: Data()))
//
//        return [c1, c2]
//    }
//}
//
//@MainActor
//extension Cat {
//    static var previewOne: Cat { PreviewFixtures.sampleCats[0] }
//    static var previewTwo: Cat { PreviewFixtures.sampleCats[1] }
//}
//#endif
