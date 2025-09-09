//
//  CatDetailHeader.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/5/25.
//

import SwiftUI

struct CatDetailHeader: View {
    struct Info {
        let name: String
        let firstMetDateText: String
    }
    
    enum Mode {
        case fixed(maxHeight: CGFloat) // Edit
        case dynamic(maxHeight: CGFloat, fadeProgress: CGFloat) // Detail
    }
    
    let imageData: Data?
    let mode: Mode
    var info: Info? = nil // 기본값 nil로 두고 정보 필요한 뷰에서 init

    var body: some View {
        switch mode {
        case .fixed(let maxHeight):
            headerImage(width: nil, height: maxHeight)
        case .dynamic(let maxHeight, let fadeProgress):
            GeometryReader { proxy in
                let globalY = proxy.frame(in: .global).minY
                let currentHeight = maxHeight + max(0, globalY) // 풀다운 시 늘어나는 효과
                headerImage(width: proxy.size.width, height: currentHeight)
                    .opacity(1 - fadeProgress)
                    .offset(y: globalY > 0 ? -globalY : 0) // 이미지 y축 고정(스크롤 다운해도 이동 안 되도록)
            }
            .frame(height: maxHeight)
        }
    }
    
    // MARK: - Subview
    @ViewBuilder
    private func headerImage(width: CGFloat?, height: CGFloat) -> some View {
        DataImage(data: imageData) { img in
            img.resizable().scaledToFill()
                .frame(width: width, height: height)
                .clipped()
                .overlay(
                    LinearGradient(colors: [.black.opacity(0.25), .clear, .black.opacity(0.25)],
                                   startPoint: .top, endPoint: .bottom)
                )
                .overlay(alignment: .bottom) {
                    if let info {
                        HStack(alignment: .bottom) {
                            Text(info.name)
                                .font(.pretendard(.bold, size: 20))
                            
                            Spacer()
                            
                            Text(info.firstMetDateText)
                                .font(.pretendard(.medium, size: 16))
                        }
                        .padding(.horizontal, 20)
                        .foregroundStyle(.netural10)
                        .padding(.bottom, 13)
                    }
                }
        }
    }
}

#Preview {
    let cat: Cat = .previewOne
    CatDetailHeader(imageData: cat.profilePhoto, mode: .fixed(maxHeight: 284), info: .init(name: cat.name, firstMetDateText: "첫만남 : \(cat.firstMetDate?.yearMonthKR ?? "미정")"))
}
