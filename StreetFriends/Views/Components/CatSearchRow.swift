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
        var attributedName = AttributedString(cat.name)
        // 기본 스타일
        attributedName.foregroundColor = .netural60
        attributedName.font = .pretendard(.regular, size: 14)
        
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedQuery.isEmpty else { return attributedName }
        
        // 1. String에서 범위를 찾기
        let stringName: String = cat.name
        if let stringRange = stringName.range(of: trimmedQuery,
                                              options: [.caseInsensitive, .diacriticInsensitive], // 대소문자 무시, 악센트 및 받침 차이 무시(라틴 문자)
                           range: stringName.startIndex..<stringName.endIndex,
                           locale: .current) {
            // 2. String.Index → AttributedString.Index 변환
            if let lower = AttributedString.Index(stringRange.lowerBound, within: attributedName),
               let upper = AttributedString.Index(stringRange.upperBound, within: attributedName) {
                let range = lower..<upper
                // 3. 하이라이트 스타일 적용
                attributedName[range].foregroundColor = .blue60
                attributedName[range].font = .pretendard(.medium, size: 14)
            }
        }
        return attributedName
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
}

#Preview {
    CatSearchRow(cat: .previewOne, query: "빵")
}
