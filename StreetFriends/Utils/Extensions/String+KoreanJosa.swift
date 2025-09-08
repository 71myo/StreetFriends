//
//  String+KoreanJosa.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/8/25.
//

import Foundation

extension String {
    // 한글이면 받침 비교해서 을, 를 return
    var eulReul: String {
        let normalized = self.precomposedStringWithCanonicalMapping
        guard let scalar = normalized.unicodeScalars.last else { return "을" } // 기본값
        let v = scalar.value
        guard (0xAC00...0xD7A3).contains(v) else { return "을" } // 외국어, 숫자, 이모지면 "을"
        let jong = (v - 0xAC00) % 28 // 0이면 받침 없음
        return jong == 0 ? "를" : "을"
    }
}
