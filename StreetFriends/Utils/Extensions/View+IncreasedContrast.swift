//
//  View+IncreasedContrast.swift
//  StreetFriends
//
//  Created by kimhyojeong on 11/10/26.
//

import SwiftUI

// MARK: - 대비 증가 설정 시 배경을 어둡게 하는 모디파이어
private struct IncreasedContrastDimming: ViewModifier {
    @Environment(\.colorSchemeContrast) private var contrast
    let opacity: Double

    func body(content: Content) -> some View {
        content
            .overlay {
                if contrast == .increased {
                    Color.black.opacity(opacity)
                        .ignoresSafeArea()
                        .allowsHitTesting(false)
                        .accessibilityHidden(true)
                }
            }
    }
}

extension View {
    /// 사용자가 "대비 증가"를 켰을 때만 배경 위에 반투명 검은색을 덮어, 흰 글자의 대비를 높임
    /// - 흰 글자가 밝은 배경 위에 있는 화면에서 사용 (기본 약 2.16 : 1 → 약 3.75 : 1)
    func dimmedForIncreasedContrast(opacity: Double = 0.25) -> some View {
        modifier(IncreasedContrastDimming(opacity: opacity))
    }
}
