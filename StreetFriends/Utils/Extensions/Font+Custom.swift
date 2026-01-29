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
        .custom(weight.rawValue, size: size)
    }
}
