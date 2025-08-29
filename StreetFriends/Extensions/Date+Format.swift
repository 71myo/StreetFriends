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
        formatter.dateFormat = "yyyy . MM . dd"
        return formatter.string(from: self)
    }
}
