//
//  String+SearchUtils.swift
//  StreetFriends
//
//  Created by Hyojeong on 12/11/25.
//

import Foundation

extension String {
    var searchFolded: String {
        self.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: .current)
            .replacingOccurrences(of: " ", with: "")
    }
}
