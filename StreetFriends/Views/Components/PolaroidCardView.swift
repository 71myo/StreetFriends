//
//  PolaroidCardView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/27/25.
//

import SwiftUI

enum PolaroidInfo {
    case home(catImage: UIImage, catName: String, recentEncountersCount: Int)
    case detail(catImage: UIImage, encounterNote: String, encounterDate: Date)
}

struct PolaroidCardView<Destination: View>: View {
    // MARK: - PROPERTIES
    let info: PolaroidInfo
    
    @ViewBuilder let destination: Destination
    
    // MARK: - BODY
    var body: some View {
        NavigationLink {
            destination
        } label: {
            ZStack {
                // 폴라로이드 배경
                Rectangle()
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
                
                // 내용물
                VStack(alignment: .leading) {
                    photoSection
                    
                    textSection
                } //: VSTACK(내용물)
                .padding(16)
            } //: ZSTACK
            .frame(height: cardHeight)
        }
    }
    
    // MARK: - SUBVIEWS
    // 1. 사진 영역
    @ViewBuilder
    private var photoSection: some View {
        switch info {
        case .home(let catImage, _, _), .detail(let catImage, _, _):
            ZStack(alignment: .topLeading) {
                Image(uiImage: catImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 240)
                    .clipped()
                
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
        case .home(_, let catName, let count):
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
            
            Spacer()
            
        case .detail(_, let note, let date):
            VStack(alignment: .leading, spacing: 10) {
                Text(note)
                    .font(.pretendard(.medium, size: 16))
                    .foregroundStyle(.netural80)
                    .lineLimit(3)
                
                
                Text(date, format: .dateTime.year().month().day())
                    .font(.pretendard(.medium, size: 14))
                    .foregroundStyle(.netural40)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.top, 12)
        }
    }
    
    // 3. 폴라로이드 높이 계산
    private var cardHeight: CGFloat {
        switch info {
        case .home:
            return 325
            
        case .detail:
            return 380
        }
    }
}

// MARK: - PREVIEW
#Preview("home") {
    PolaroidCardView(
        info: .home(
            catImage: UIImage(resource: .sampleCat),
            catName: "찐빵이",
            recentEncountersCount: 12), destination: {}
    )
    .padding()
}

#Preview("detail") {
    PolaroidCardView(
        info: .detail(
            catImage: UIImage(resource: .sampleCat),
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
