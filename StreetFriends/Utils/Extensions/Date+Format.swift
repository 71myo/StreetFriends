//
//  Date+Format.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/30/25.
//

import Foundation

extension Date {
    var formattedDot: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: self)
    }
}

extension Date {
    var formattedDotYM: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM"
        return formatter.string(from: self)
    }
}

extension Date {
    var yearMonthKR: String {
        self.formatted(.dateTime.year().month().locale(Locale(identifier: "ko_KR")))
    }
}
