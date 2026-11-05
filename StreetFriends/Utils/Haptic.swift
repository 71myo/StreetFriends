//
//  Haptic.swift
//  StreetFriends
//
//  Created by kimhyojeong on 11/5/26.
//

import UIKit

enum Haptic {
    /// 즐겨찾기 토글
    static func favoriteToggled() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}
