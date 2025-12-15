//
//  PolaroidShareCardView.swift
//  StreetFriends
//
//  Created by Hyojeong on 12/15/25.
//

import SwiftUI

struct PolaroidShareCardView: View {
    let photo: UIImage?
    let catName: String
    let recentEncountersCount: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
            
            VStack(alignment: .leading, spacing: 0) {
                // 사진 영역
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
                
                // 텍스트 영역
                VStack(alignment: .leading, spacing: 5) {
                    Text(catName)
                        .font(.pretendard(.medium, size: 16))
                        .foregroundStyle(.netural80)
                        .lineLimit(1)
                    
                    Text("총 \(recentEncountersCount)번 마주쳤어요")
                        .font(.pretendard(.medium, size: 14))
                        .foregroundStyle(.netural40)
                }
                .padding(.top, 12)
            }
            .padding(16)
        }
        .frame(width: 335, height: 340)
    }
}

#Preview {
    PolaroidShareCardView(photo: nil, catName: "흠냐", recentEncountersCount: 3)
}
