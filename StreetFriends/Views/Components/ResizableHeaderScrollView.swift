//
//  ResizableHeaderScrollView.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/5/25.
//

import SwiftUI

/// 상단 헤더가 스크롤에 따라 최소/최대로 리사이즈되는 컨테이너
struct ResizableHeaderScrollView<Header: View, Content: View>: View {
    let minimumHeight: CGFloat
    let maximumHeight: CGFloat
    var onProgress: ((CGFloat) -> Void)? = nil
    
    /// Resize Progress, SafeArea Values 전달
    @ViewBuilder var header: (_ progress: CGFloat, _ safeArea: EdgeInsets) -> Header
    @ViewBuilder var content: () -> Content
    
    // 스크롤 오프셋(위로 스크롤할수록 증가, 내리면 음수)
    @State private var offsetY: CGFloat = 0

    var body: some View {
        GeometryReader { proxy in
            let safeArea = proxy.safeAreaInsets
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    Section {
                        content()
                    } header: {
                        GeometryReader { _ in
                            let progress: CGFloat = min(max(offsetY / (maximumHeight - minimumHeight), 0), 1)
                            let resizedHeight = (maximumHeight + safeArea.top) - (maximumHeight - minimumHeight) * progress
                            
                            header(progress, safeArea)
                                .frame(height: resizedHeight, alignment: .bottom)
                                .onChange(of: progress) { _, newValue in
                                    onProgress?(newValue)
                                }
                        }
                        .frame(height: maximumHeight + safeArea.top)
                    }
                }
            }
            /// Offset is needed to calculate the progress value
            .onScrollGeometryChange(for: CGFloat.self) {
                $0.contentOffset.y + $0.contentInsets.top
            } action: { _, newValue in
                offsetY = newValue
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}
