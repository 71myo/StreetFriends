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
        let firstMetDate: String
    }
    
    let imageData: Data?
    let maxHeight: CGFloat
    var fadeProgress: CGFloat = 0
    var info: Info? = nil // 기본값 nil로 두고 정보 필요한 뷰에서 init

    var body: some View {
            GeometryReader { proxy in
                let globalY = proxy.frame(in: .global).minY
                let pullDistance = max(0, globalY)

                headerImage(width: proxy.size.width, height: maxHeight + pullDistance)
                    .opacity(1 - fadeProgress)
                    .offset(y: -pullDistance) // 늘어난 만큼 위로 올려 화면 맨 위에 고정
            }
            .frame(height: maxHeight)
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
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                            
                            ViewThatFits(in: .horizontal) {
                                Text("첫만남: \(info.firstMetDate)")
                                    .lineLimit(1)
                                
                                Text("첫만남:\n\(info.firstMetDate)")
                                    .multilineTextAlignment(.trailing)
                            }
                                .font(.pretendard(.medium, size: 16))
                        }
                        .dynamicTypeSize(...DynamicTypeSize.accessibility3)
                        .padding(.horizontal, 20)
                        .foregroundStyle(.netural10)
                        .padding(.bottom, 13)
                    }
                }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(info.map { "\($0.name) 사진, 첫만남 \($0.firstMetDate)" } ?? "친구 사진")
    }
}

#Preview {
    let cat: Cat = .previewOne
    CatDetailHeader(imageData: cat.profilePhoto, maxHeight: 284)
}
