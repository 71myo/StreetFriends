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
    
    @Environment(\.dismiss) private var dismiss
    let cat: Cat
    
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
                    
                    DataImage(data: cat.profilePhoto) { img in
                        img.resizable().scaledToFill()
                            .frame(width: proxy.size.width, height: currentHeight)
                            .clipped()
                            .overlay(
                                LinearGradient(colors: [.black.opacity(0.25), .clear, .black.opacity(0.25)],
                                               startPoint: .top, endPoint: .bottom)
                            )
                            .overlay(alignment: .bottom) {
                                HStack(alignment: .bottom) {
                                    Text(cat.name)
                                        .font(.pretendard(.bold, size: 20))
                                    
                                    Spacer()
                                    
                                    Text("첫만남 : \(cat.firstMetDate?.yearMonthKR ?? "미정")")
                                        .font(.pretendard(.medium, size: 16))
                                }
                                .padding(.horizontal, 20)
                                .foregroundStyle(.netural10)
                                .padding(.bottom, 13)
                            }
                            .opacity(1 - progress)
                            .offset(y: globalY > 0 ? -globalY : 0)
                    }
                } //: GEOMETRY
                .frame(height: 284)
            } content: {
                // MARK: - CONTENT
                VStack(spacing: 40) {
                    ForEach(cat.encounters) { encounter in
                        PolaroidCardView(info: .detail(encounter: encounter, catImageData: encounter.photo,
                                                       encounterNote: encounter.note, encounterDate: encounter.date),
                                         destination: {})
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 40)
            } //: SCROLL
            .ignoresSafeArea()
            .navigationBarBackButtonHidden()
            
            NavigationBar(title: isCollapsed ? cat.name : "", style: isCollapsed ? .solid : .clear,
                          leading: { Button { dismiss() } label: { Image(.chevronLeftPaper) } },
                          trailing: {
                HStack(spacing: 12) {
                    Button {} label: { Image(.selectTrue) }
                    Button {} label: { Image(.morePaper) }
                }
            })
            .animation(.easeInOut(duration: 0.4), value: isCollapsed)
        }
    }
}

#Preview {
    CatDetailView(cat: .previewOne)
}
