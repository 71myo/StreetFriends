//
//  View+BarIcon.swift
//  StreetFriends
//
//  Created by kimhyojeong on 11/10/26.
//

import SwiftUI

extension View {
    /// 내비게이션 바 아이콘 버튼용 접근성 설정
    /// 1. VoiceOver 라벨
    /// 2. 큰 글자(접근성 크기)에서 길게 누르면 아이콘과 이름을 크게 보여 줌

    /// 에셋 이미지 아이콘용
    func barIconAccessibility(_ label: String, image: ImageResource) -> some View {
        self
            .accessibilityLabel(label)
            .accessibilityShowsLargeContentViewer {
                Label(label, image: image)
            }
    }
    
    /// SF Symbol 아이콘용
    func barIconAccessibility(_ label: String, systemImage: String) -> some View {
        self
            .accessibilityLabel(label)
            .accessibilityShowsLargeContentViewer {
                Label(label, systemImage: systemImage)
            }
    }
    
    /// 내비게이션 바 아이콘 버튼의 터치 영역을 최소 44x44pt로 넓힘
    func barIconTapArea() -> some View {
        self
            .frame(minWidth: 44, minHeight: 44)
            .contentShape(Rectangle())
    }
}
