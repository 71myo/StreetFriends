//
//  CatDetailView.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/2/25.
//

import SwiftUI

struct CatDetailView: View {
    // MARK: - PROPERTIES
    @Environment(\.dismiss) private var dismiss
    @State private var headerProgress: CGFloat = 0
    
    let cat: Cat
    private var isCollapsed: Bool { headerProgress >= 0.85 }
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .top) {
            Background()
            
            ResizableHeaderScrollView(minimumHeight: 110,
                                      maximumHeight: 284,
                                      onProgress: { headerProgress = $0 }
            ) { progress, safeArea in
                // MARK: - HEADER
                CatDetailHeader(imageData: cat.profilePhoto,
                                name: cat.name,
                                firstMetDateText: "첫만남 : \(cat.firstMetDate?.yearMonthKR ?? "미정")",
                                maxHeight: 284,
                                progress: progress)
            } content: {
                // MARK: - CONTENT
                VStack(spacing: 40) {
                    ForEach(cat.encounters) { encounter in
                        PolaroidCardView(
                            info: .detail(encounter: encounter,
                                          catImageData: encounter.photo,
                                          encounterNote: encounter.note,
                                          encounterDate: encounter.date),
                            destination: {}
                        )
                        .debugBorder(.blue)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 40)
                .debugBorder(.green)
            } //: RESIZABLE HEADER SCROLLVIEW
            .safeAreaInset(edge: .top) {
                NavigationBar(
                    title: isCollapsed ? cat.name : "",
                    style: isCollapsed ? .solid : .clear,
                    leading: { Button { dismiss() } label: { Image(.chevronLeftPaper) } },
                    trailing: {
                        HStack(spacing: 12) {
                            Button {} label: { Image(.selectTrue) } // TODO: 즐겨찾기 액션 연결
                            Button {} label: { Image(.morePaper) }
                        }
                    }
                )
                .animation(.easeInOut(duration: 0.4), value: isCollapsed)
            }
        }
    }
}

#Preview {
    CatDetailView(cat: .previewOne)
}

extension View {
    func debugBorder(_ color: Color = .red) -> some View {
        overlay(Rectangle().stroke(color, lineWidth: 1))
    }
}

