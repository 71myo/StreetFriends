//
//  String+SearchUtils.swift
//  StreetFriends
//
//  Created by Hyojeong on 12/11/25.
//

import Foundation

// MARK: - 공백 제거 + 대소문자 무시
extension String {
    var searchFolded: String {
        self.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: .current)
            .replacingOccurrences(of: " ", with: "")
    }
}
