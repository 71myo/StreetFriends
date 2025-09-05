//
//  CatDetailHeader.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/5/25.
//

import SwiftUI

struct CatDetailHeader: View {
    let imageData: Data?
    let name: String
    let firstMetDateText: String
    let maxHeight: CGFloat
    let progress: CGFloat
    
    var body: some View {
        GeometryReader { proxy in
            let globalY = proxy.frame(in: .global).minY
            let currentHeight = 284 + max(0, globalY) // 풀다운 시 늘어나는 효과
            
            DataImage(data: imageData) { img in
                img.resizable().scaledToFill()
                    .frame(width: proxy.size.width, height: currentHeight)
                    .clipped()
                    .overlay(
                        LinearGradient(colors: [.black.opacity(0.25), .clear, .black.opacity(0.25)],
                                       startPoint: .top, endPoint: .bottom)
                    )
                    .overlay(alignment: .bottom) {
                        HStack(alignment: .bottom) {
                            Text(name)
                                .font(.pretendard(.bold, size: 20))
                            
                            Spacer()
                            
                            Text(firstMetDateText)
                                .font(.pretendard(.medium, size: 16))
                        }
                        .padding(.horizontal, 20)
                        .foregroundStyle(.netural10)
                        .padding(.bottom, 13)
                    }
                    .opacity(1 - progress) // 스크롤 올라갈수록 페이드아웃
                    .offset(y: globalY > 0 ? -globalY : 0) // 이미지 y축 고정(스크롤 다운해도 이동 안 되도록)
            }
        } //: GEOMETRY
        .frame(height: maxHeight)
    }
}

#Preview {
    let cat: Cat = .previewOne
    CatDetailHeader(imageData: cat.profilePhoto, name: cat.name, firstMetDateText: "첫만남 : \(cat.firstMetDate?.yearMonthKR ?? "미정")", maxHeight: 840, progress: 0)
}
