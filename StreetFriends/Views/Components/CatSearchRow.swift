//
//  CatSearchView.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/1/25.
//

import SwiftUI

struct CatSearchRow: View {
    let cat: Cat // text
    let query: String // highlightText
    
    private var highlightedName: AttributedString {
        var a = AttributedString(cat.name)
        a.foregroundColor = .netural60
        a.font = .pretendard(.regular, size: 14)

        let q = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !q.isEmpty else { return a }

        // 1) 일반 직매칭
        if let r = cat.name.range(of: q, options: [.caseInsensitive, .diacriticInsensitive]),
           let lo = AttributedString.Index(r.lowerBound, within: a),
           let up = AttributedString.Index(r.upperBound, within: a) {
            a[lo..<up].foregroundColor = .blue60
            a[lo..<up].font = .pretendard(.medium, size: 14)
            return a
        }

        // 2) 공백 무시 매칭
        if let r2 = highlightRangeIgnoringSpaces(in: cat.name, query: q),
           let lo = AttributedString.Index(r2.lowerBound, within: a),
           let up = AttributedString.Index(r2.upperBound, within: a) {
            a[lo..<up].foregroundColor = .blue60
            a[lo..<up].font = .pretendard(.medium, size: 14)
        }
        return a
    }
    
    var body: some View {
        HStack(spacing: 14) {
            CatSquareView(catImageData: cat.profilePhoto, type: .standard)
                .frame(width: 44, height: 44)
            
            Text(highlightedName)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 24)
    }
    
    // 공백을 무시하고(대소문/악센트도 무시) 매칭된 원문 범위를 돌려줌
    private func highlightRangeIgnoringSpaces(in source: String, query: String) -> Range<String.Index>? {
        let foldedSource = source.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: .current)
        let foldedQuery  = query.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: .current)

        let compactSource = foldedSource.replacingOccurrences(of: " ", with: "")
        let compactQuery  = foldedQuery.replacingOccurrences(of: " ", with: "")
        guard !compactQuery.isEmpty, let r = compactSource.range(of: compactQuery) else { return nil }

        // 원문에서 '공백 아닌 문자'들의 인덱스 배열을 만들어 위치 매핑
        var nonSpaceOriginal: [String.Index] = []
        nonSpaceOriginal.reserveCapacity(source.count)
        for i in source.indices where source[i] != " " {
            nonSpaceOriginal.append(i)
        }

        let lower = compactSource.distance(from: compactSource.startIndex, to: r.lowerBound)
        let upper = compactSource.distance(from: compactSource.startIndex, to: r.upperBound) // exclusive

        guard lower < nonSpaceOriginal.count else { return nil }
        let start = nonSpaceOriginal[lower]
        let end   = (upper - 1 < nonSpaceOriginal.count)
                  ? source.index(after: nonSpaceOriginal[upper - 1])
                  : source.endIndex
        return start..<end
    }
}

#Preview {
    CatSearchRow(cat: .previewOne, query: "빵")
}
