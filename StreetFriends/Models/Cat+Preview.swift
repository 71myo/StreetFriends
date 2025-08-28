//
//  Cat+Preview.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/21/25.
//

import Foundation
import SwiftData
import UIKit

extension Cat {
    @MainActor
    static var preview: ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Cat.self, Encounter.self, configurations: config)
        
        func daysAgo(_ d: Int) -> Date {
            Calendar.current.date(byAdding: .day, value: -d, to: Date()) ?? Date()
        }
        
        // 간단한 더미 이미지 Data 생성
        func imageData(_ text: String, color: UIColor) -> Data {
            let size = CGSize(width: 360, height: 360)
            let renderer = UIGraphicsImageRenderer(size: size)
            let img = renderer.image { ctx in
                color.setFill()
                ctx.fill(CGRect(origin: .zero, size: size))
                let attrs: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 120, weight: .black),
                    .foregroundColor: UIColor.white
                ]
                let ns = NSString(string: text)
                let s = ns.size(withAttributes: attrs)
                let rect = CGRect(x: (size.width - s.width)/2,
                                  y: (size.height - s.height)/2,
                                  width: s.width, height: s.height)
                ns.draw(in: rect, withAttributes: attrs)
            }
            return img.jpegData(compressionQuality: 0.9) ?? Data()
        }
        
        // MARK: - SAMPLE 1: 찐빵이
        let firstJJDate = daysAgo(6)
        let firstJJ = Encounter(date: firstJJDate, note: "철길 지나가다가 만난 치즈고양이. 원래 있던 친구가 입양가고 새로운 친구가 왔다! 얼굴이 뭔가 빵실해서 찐빵이라고 부르기로 했다", photo: imageData("JJ", color: .systemOrange))
        
        let jjinbbang = Cat(name: "찐빵이", firstEncounter: firstJJ)
        
        let jj2 = Encounter(date: daysAgo(2), note: "찐빵이를 어제 봤던 그 자리에서 또 만났다. 나를 알아보고 냅다 누워서 오늘은 츄르를 줬다.", photo: imageData("JJ2", color: .systemTeal))
        
        jjinbbang.addEncounter(jj2)
        
        
        // MARK: - SAMPLE 2: 탄빵이
        let firstTBDate = daysAgo(1)
        let firstTB = Encounter(date: firstTBDate, note: "온몸이 까만 고양이. 경계심이 많아 가까이 다가가기는 어려웠다. 얘는 아직 사람 손을 덜 탔나보다.", photo: imageData("TB", color: .systemIndigo))
        
        let tanbbang = Cat(name: "탄빵이", firstEncounter: firstTB)

        let tb2 = Encounter(date: Date(), note: "오늘은 조금 더 가까이 와서 냄새를 맡았다. 너무 귀엽다!", photo: imageData("TB2", color: .systemPink))
        
        tanbbang.addEncounter(tb2)
        
        let ctx = container.mainContext
        
        ctx.insert(jjinbbang)
        ctx.insert(tanbbang)
        try? ctx.save()
        
        return container
    }
}
