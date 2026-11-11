//
//  MonthlyTopCat.swift
//  StreetFriends
//
//  Created by kimhyojeong on 11/11/26.
//

import Foundation

/// 이번 달에 가장 많이 만난 친구 계산(홈 화면과 위젯 함께 사용)
enum MonthlyTopCat {
    struct Result {
        let cat: Cat
        let count: Int
    }

    /// 기준 날짜가 속한 달의 기간 (1일 0시 ~ 다음 달 1일 0시)
    static func monthInterval(for date: Date = .now, calendar: Calendar = .current) -> DateInterval? {
        calendar.dateInterval(of: .month, for: date)
    }

    /// 이번 달에 가장 많이 만난 친구
    /// - 동점이면 이번 달에 가장 최근에 만난 친구, 그것도 같으면 먼저 등록한 친구
    static func top(from encounters: [Encounter], in month: DateInterval) -> Result? {
        // 친구별 이번 달 기록
        struct Stat {
            let cat: Cat
            var count: Int
            var lastDate: Date
        }

        var stats: [UUID: Stat] = [:]

        for encounter in encounters {
            guard let cat = encounter.cat,
                  encounter.date >= month.start,
                  encounter.date < month.end else { continue }

            if var stat = stats[cat.id] {
                stat.count += 1
                stat.lastDate = max(stat.lastDate, encounter.date)
                stats[cat.id] = stat
            } else {
                stats[cat.id] = Stat(cat: cat, count: 1, lastDate: encounter.date)
            }
        }

        let best = stats.values.max { a, b in
            if a.count != b.count { return a.count < b.count } // 1. 횟수가 많은 친구
            if a.lastDate != b.lastDate { return a.lastDate < b.lastDate } // 2. 최근에 만난 친구
            return a.cat.creationDate > b.cat.creationDate // 3. 먼저 등록한 친구
        }

        return best.map { Result(cat: $0.cat, count: $0.count) }
    }
}
