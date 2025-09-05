//
//  ResizableHeaderScrollView.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/5/25.
//

import SwiftUI

struct ResizableHeaderScrollView<Header: View, Content: View>: View {
    var minimumHeight: CGFloat
    var maximumHeight: CGFloat

    /// Resize Progress, SafeArea Values
    @ViewBuilder var header: (CGFloat, EdgeInsets) -> Header
    @ViewBuilder var content: Content
    /// View Properties
    @State private var offsetY: CGFloat = 0 // 오프셋 스크롤, 위로 스크롤할수록 증가, 내릴 때 음수
    
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    Section {
                        content
                    } header: {
                        GeometryReader { _ in
                            let progress: CGFloat = min(max(offsetY / (maximumHeight - minimumHeight), 0), 1)
                            let resizedHeight = (maximumHeight + safeArea.top) - (maximumHeight - minimumHeight) * progress
                            
                            header(progress, safeArea)
                                .frame(height: resizedHeight, alignment: .bottom)
                        }
                        .frame(height: maximumHeight + safeArea.top)
                    }
                }
            }
            /// Offset is needed to calculate the progress value
            .onScrollGeometryChange(for: CGFloat.self) {
                $0.contentOffset.y + $0.contentInsets.top
            } action: { oldValue, newValue in
                offsetY = newValue
            }
        }
    }
}
