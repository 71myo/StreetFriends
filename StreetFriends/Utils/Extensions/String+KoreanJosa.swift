//
//  String+KoreanJosa.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/8/25.
//

import Foundation

extension String {
    // 마지막 글자 받침 확인
    private var hasJongseong: Bool? {
        let normalized = self.precomposedStringWithCanonicalMapping
        guard let scalar = normalized.unicodeScalars.last else { return nil }
        let v = scalar.value
        guard (0xAC00...0xD7A3).contains(v) else { return nil }
        return (v - 0xAC00) % 28 != 0 // 0이면 받침 없음
    }
    
    // 을/를
    var eulReul: String {
        guard let has = hasJongseong else { return "을" } // 한글이 아니면 기본값
        return has ? "을" : "를"
    }

    // 와/과
    var waGwa: String {
        guard let has = hasJongseong else { return "과" } // 한글이 아니면 기본값
        return has ? "과" : "와"
    }
}
