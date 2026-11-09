//
//  Font+Custom.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/14/25.
//

import SwiftUI

extension Font {
    enum Pretendard: String {
        case black = "Pretendard-Black"
        case bold = "Pretendard-Bold"
        case medium = "Pretendard-Medium"
        case regular = "Pretendard-Regular"
        case semiBold = "Pretendard-SemiBold"
    }
    
    static func pretendard(_ weight: Pretendard, size: CGFloat) -> Font {
        .custom(weight.rawValue, size: size, relativeTo: textStyle(for: size))
    }
    
    /// 글자 크기와 가장 가까운 시스템 텍스트 스타일을 적용해 그 비율로 Dynamic Type 적용하도록 함
    private static func textStyle(for size: CGFloat) -> Font.TextStyle {
        switch size {
            case 28...: return .title
            case 22..<28: return .title3
            case 20..<22: return .title3
            case 17..<20: return .body
            case 16..<17: return .callout
            case 14..<16: return .subheadline
            case 13..<14: return .footnote
            default: return .caption
        }
    }
}
