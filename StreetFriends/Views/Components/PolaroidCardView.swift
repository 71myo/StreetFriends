//
//  PolaroidCardView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/27/25.
//

import SwiftUI

struct PolaroidCardView<Destination: View>: View {
    // MARK: - ENUM
    enum PolaroidInfo {
        case home(cat: Cat, catImageData: Data?, catName: String, recentEncountersCount: Int)
        case detail(encounter: Encounter, catImageData: Data?, encounterNote: String, encounterDate: Date)
    }
    
    // MARK: - PROPERTIES
    let info: PolaroidInfo
    @ViewBuilder var destination: () -> Destination
    
    // MARK: - BODY
    var body: some View {
        NavigationLink {
            destination()
        } label: {
            ZStack {
                // 폴라로이드 배경
                Rectangle()
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
                
                // 내용물
                VStack(alignment: .leading, spacing: 0) {
                    photoSection
                    textSection
                }
                .padding(16)
            } //: ZSTACK
            .frame(maxWidth: .infinity)
        }
    }
    
    // MARK: - SUBVIEWS
    // 1. 사진 영역
    @ViewBuilder
    private var photoSection: some View {
        switch info {
        case .home(_, let catImageData, _, _), .detail(_, let catImageData, _, _):
            ZStack(alignment: .topLeading) {
                GeometryReader { geo in
                    DataImage(data: catImageData, fixedHeight: 240) { img in
                        img
                            .resizable()
                            .scaledToFill()
                    }
                    .frame(width: geo.size.width, height: 240)
                    .clipped()
                } //: GEOMETRY
                .frame(height: 240)
                
                if case .home = info {
                    Image(.crown)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .rotationEffect(Angle(degrees: -12))
                        .offset(x: -30, y: -30)
                        .shadow(color: .black.opacity(0.25), radius: 1, x: 0, y: 1)
                }
            }
        }
    }
    
    // 2. 글씨 영역
    @ViewBuilder
    private var textSection: some View {
        switch info {
        case .home(_, _, let catName, let count):
            VStack(alignment: .leading, spacing: 5) {
                Text(catName)
                    .font(.pretendard(.medium, size: 16))
                    .foregroundStyle(.netural80)
                    .lineLimit(1)
                
                Text("30일간 \(count)번 마주쳤어요")
                    .font(.pretendard(.medium, size: 14))
                    .foregroundStyle(.netural40)
            }
            .padding(.top, 12)
            
        case .detail(_, _, let note, let date):
            VStack(alignment: .leading, spacing: 4) {
                Text(note)
                    .font(.pretendard(.medium, size: 16))
                    .foregroundStyle(.netural70)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                
                Text(date.formattedDot)
                    .font(.pretendard(.medium, size: 14))
                    .foregroundStyle(.netural30)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.top, 16)
        }
    }
}

// MARK: - PREVIEW
#Preview("home") {
    let cat: Cat = .previewOne
    PolaroidCardView(
        info: .home(
            cat: cat, catImageData: cat.profilePhoto,
            catName: cat.name,
            recentEncountersCount: 12), destination: {}
    )
    .padding()
}

#Preview("detail") {
    let encounter = Cat.previewOne.encounters.first!
    
    PolaroidCardView(
        info: .detail(
            encounter: encounter, catImageData: encounter.photo,
            encounterNote: """
                       철길 지나가다가 만난 치즈고양이
                       원래 있던 친구가 입양가고 새로운 친구가 왔다!
                       얼굴이 뭔가 빵실해서 찐빵이라고 부르기로 했다

                       처음 만났는데 멋있는 자세로 그루밍을 하는 모습ㅋㅋ
                       사람을 경계하진 않는데 그렇다고 만지면 또 자리를 피한다
                       """,
            encounterDate: .now
        ), destination: {}
    )
    .padding()
}
