//
//  CatDetailView.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/2/25.
//

import SwiftUI

struct CatDetailView: View {
    // MARK: - PROPERTIES
    @State private var headerProgress: CGFloat = 0
    private let collapseThreshold: CGFloat = 0.85   // 어느 정도 올랐을 때 solid로 전환할지
    
    private var isCollapsed: Bool { headerProgress >= collapseThreshold }
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .top) {
            Background()
            
            ResizableHeaderScrollView(minimumHeight: 110, maximumHeight: 284) { progress, safeArea in
                // progress 반영
                Color.clear
                    .frame(height: 0)
                    .onChange(of: progress) { _, newValue in
                        headerProgress = newValue
                    }
                
                // MARK: - HEADER
                GeometryReader { proxy in
                    let globalY = proxy.frame(in: .global).minY
                    let currentHeight = 284 + max(0, globalY)
                    
                    Image(.sampleCat)
                        .resizable()
                        .scaledToFill()
                        .frame(width: proxy.size.width, height: currentHeight)
                        .clipped()
                        .overlay(
                            LinearGradient(colors: [.black.opacity(0.25), .clear, .black.opacity(0.25)], startPoint: .top, endPoint: .bottom)
                        )
                        .opacity(1 - progress)
                        .overlay(alignment: .bottomLeading) {
                            Text("찐빵이")
                                .font(.pretendard(.bold, size: 20))
                                .foregroundStyle(.netural10)
                                .padding(.leading, 20)
                                .padding(.bottom, 13)
                                .opacity(1 - progress)
                        }
                        .overlay(alignment: .bottomTrailing) {
                            Text("첫만남 : 2023년 3월")
                                .font(.pretendard(.medium, size: 16))
                                .foregroundStyle(.netural10)
                                .padding(.trailing, 20)
                                .padding(.bottom, 13)
                                .opacity(1 - progress)
                        }
                        .offset(y: globalY > 0 ? -globalY : 0)
                } //: GEOMETRY
                .frame(height: 284)
            } content: {
                // MARK: - CONTENT
                VStack(spacing: 40) {
                    ForEach(0..<3) { _ in
                        PolaroidCardView(info: .detail(catImage: .sampleCat, encounterNote: "철길 지나가다가 만난 치즈고양이\n원래 있던 친구가 입양가고 새로운 친구가 왔다!\n얼굴이 뭔가 빵실해서 찐빵이라고 부르기로 했다. 사람을 경계하진 않는데 그렇다고 만지면 또 자리를 피한다", encounterDate: .now), destination: {})
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 40)
            } //: SCROLL
            .ignoresSafeArea()
            
            NavigationBar(title: isCollapsed ? "찐빵이" : "", style: isCollapsed ? .solid : .clear,
                          leading: { Button {} label: { Image(.chevronLeftPaper) } },
                          trailing: {
                HStack(spacing: 12) {
                    Button {} label: { Image(.selectTrue) }
                    Button {} label: { Image(.morePaper) }
                }
            })
            .opacity(isCollapsed ? 1 : 0)
            .animation(.easeInOut(duration: 0.4), value: isCollapsed)
        }
    }
}

#Preview {
    CatDetailView()
}
