//
//  PolaroidShareCardView.swift
//  StreetFriends
//
//  Created by Hyojeong on 12/15/25.
//

import SwiftUI

struct PolaroidShareCardView: View {
    enum Mode {
        case cat(photo: UIImage?, name: String, totalEncountersCount: Int, date: Date)
        case encounter(photo: UIImage?, note: String, date: Date)
    }
    
    let mode: Mode
    let cardWidth: CGFloat
    
    var cardHeight: CGFloat {
        switch mode {
        case .cat: return 335
        case .encounter: return 373
        }
    }
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
            
            VStack(alignment: .leading, spacing: 12) {
                photoSection
                textSection
            }
            .padding(16)
        } //: 전체 ZSTACK
        .frame(width: cardWidth, height: cardHeight)
        .padding(24)
        .background(Color.clear)
    }
    
    // MARK: - PHOTO
    @ViewBuilder
    private var photoSection: some View {
        var photo: UIImage? {
            switch mode {
            case let .cat(photo: photo, _, _, _): return photo
            case let .encounter(photo: photo, _, _): return photo
            }
        }
        
        ZStack {
            Rectangle().foregroundStyle(.netural30)
            if let photo {
                Image(uiImage: photo)
                    .resizable()
                    .scaledToFill()
            } else {
                Image(.mysteryCat)
                    .resizable()
                    .scaledToFit()
                    .padding(10)
            }
        } //: ZSTACK
        .frame(maxWidth: .infinity, minHeight: 240, maxHeight: 240)
        .clipped()
    }
    
    // MARK: - TEXT
    @ViewBuilder
    private var textSection: some View {
        switch mode {
        case let .cat(_, name: name, totalEncountersCount: total, date: date):
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.pretendard(.semiBold, size: 20))
                    .foregroundStyle(.netural70)
                    .lineLimit(1)
                
                HStack(alignment: .bottom) {
                    Text("총 \(total)번 마주쳤어요")
                        .font(.pretendard(.medium, size: 16))
                        .foregroundStyle(.netural40)
                    
                    Spacer()
                    
                    Text("\(date.formattedDotYM) 첫 만남")
                        .font(.pretendard(.medium, size: 14))
                        .foregroundStyle(.netural30)
                }
            }
            
        case let .encounter(_, note: note, date: date):
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
        }
    }
}

#Preview("고양이 공유") {
    PolaroidShareCardView(mode: .cat(photo: nil, name: "찐빵이", totalEncountersCount: 3, date: .now), cardWidth: 320)
}
#Preview("추억 공유") {
    PolaroidShareCardView(mode: .encounter(photo: nil, note: """
                       철길 지나가다가 만난 치즈고양이
                       원래 있던 친구가 입양가고 새로운 친구가 왔다!
                       얼굴이 뭔가 빵실해서 찐빵이라고 부르기로 했다

                       처음 만났는데 멋있는 자세로 그루밍을 하는 모습ㅋㅋ
                       사람을 경계하진 않는데 그렇다고 만지면 또 자리를 피한다
                       """, date: .now), cardWidth: 335)
}
