//
//  CatDetailView.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/2/25.
//

import SwiftUI

struct CatDetailView: View {
    // MARK: - PROPERTIES
    private let headerMaxHeight: CGFloat = 284
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .top) {
            Background()
            
            ScrollView {
                VStack(spacing: 0) {
                    // MARK: - 헤더 이미지
                    GeometryReader { proxy in
                        let globalY = proxy.frame(in: .global).minY
                        let stretch = max(0, globalY) // 당겼을 때 양수
                        let currentHeight = headerMaxHeight + stretch
                        
                        Image(.sampleCat)
                            .resizable()
                            .scaledToFill()
                            .frame(width: proxy.size.width, height: currentHeight)
                            .clipped()
                            .overlay(
                                LinearGradient(colors: [.black.opacity(0.25), .clear, .black.opacity(0.25)], startPoint: .top, endPoint: .bottom)
                            )
                            .overlay(alignment: .bottom) {
                                HStack {
                                    Text("찐빵이")
                                        .font(.pretendard(.bold, size: 20))
                                    
                                    Spacer()
                                    
                                    Text("첫만남 : 2023년 3월")
                                        .font(.pretendard(.medium, size: 16))
                                }
                                .foregroundStyle(.white)
                                .padding(.horizontal, 20)
                                .padding(.bottom, 13)
                            }
                            .offset(y: stretch > 0 ? -stretch : 0)
                    } //: GEOMETRY
                    .frame(height: headerMaxHeight)
                    
                    // MARK: - 폴라로이드 리스트
                    VStack {
                        ForEach(0..<3) { _ in
                            PolaroidCardView(info: .detail(catImage: .sampleCat, encounterNote: "철길 지나가다가 만난 치즈고양이\n원래 있던 친구가 입양가고 새로운 친구가 왔다!\n얼굴이 뭔가 빵실해서 찐빵이라고 부르기로 했다. 사람을 경계하진 않는데 그렇다고 만지면 또 자리를 피한다", encounterDate: .now), destination: {})
                                .padding(.top, 40)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            } //: SCROLL
            
            NavigationBar(title: "", style: .clear,
                          leading: { Button {} label: { Image(.chevronLeftPaper) } },
                          trailing: {
                HStack(spacing: 12) {
                    Button {} label: { Image(.selectTrue) }
                    Button {} label: { Image(.morePaper) }
                }
            })
        }
    }
}

#Preview {
    CatDetailView()
}
