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

// MARK: - 한글 매칭 헬퍼
private let CHOSEONG: [Character] = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
private let VOWEL_JAMO: Set<Character> = ["ㅏ","ㅐ","ㅑ","ㅒ","ㅓ","ㅔ","ㅕ","ㅖ","ㅗ","ㅛ","ㅜ","ㅠ","ㅡ","ㅣ"]
private let CONSONANT_JAMO: Set<Character> = Set(CHOSEONG)

private func isHangulSyllable(_ v: UInt32) -> Bool { (0xAC00...0xD7A3).contains(v) }

// 한글 음절 분해 (초/중/종) - 종성 0은 없음
private func decompose(_ ch: Character) -> (cho: Int, jung: Int, jong: Int)? {
    guard let v = String(ch).unicodeScalars.first?.value, isHangulSyllable(v) else { return nil }
    let s = Int(v - 0xAC00)
    return (s / 588, (s % 588) / 28, s % 28)
}

private func initialOf(_ ch: Character) -> Character? {
    guard let v = String(ch).unicodeScalars.first?.value, isHangulSyllable(v) else { return nil }
    return CHOSEONG[Int((v - 0xAC00) / 588)]
}

private func isAllVowels(_ q: String) -> Bool {
    let t = q.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !t.isEmpty else { return false }
    return t.allSatisfy { VOWEL_JAMO.contains($0) || $0.isWhitespace }
}

private func stripSpaces(_ s: String) -> [Character] {
    s.filter { !$0.isWhitespace }
}

/// ✅ Bool 매칭 전용
func matchesKoreanNameAnywhere(_ name: String, query raw: String) -> Bool {
    let q = raw.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !q.isEmpty else { return false }
    if isAllVowels(q) { return false } // "모음만" 쿼리는 불매치

    let nameChars = Array(name.filter { !$0.isWhitespace })
    let queryChars = Array(stripSpaces(q))
    guard !queryChars.isEmpty else { return false }

    // 단일 글자 최적화
    if queryChars.count == 1, let qc = queryChars.first {
        if CONSONANT_JAMO.contains(qc) {
            return nameChars.contains { initialOf($0) == qc }
        } else if VOWEL_JAMO.contains(qc) {
            return false
        } else if let qd = decompose(qc) {
            return nameChars.contains { nc in
                if let nd = decompose(nc) {
                    let choOK = qd.cho == nd.cho
                    let jungOK = qd.jung == nd.jung
                    let jongOK = (qd.jong == 0) || (qd.jong == nd.jong)
                    return choOK && jungOK && jongOK
                }
                return String(nc).searchFolded == String(qc).searchFolded
            }
        } else {
            return name.range(of: String(qc), options: [.caseInsensitive, .diacriticInsensitive]) != nil
        }
    }

    // 다글자 슬라이딩 윈도우 매칭
    let m = queryChars.count
    guard m <= nameChars.count else { return false }

    outer: for start in 0...(nameChars.count - m) {
        for i in 0..<m {
            let qc = queryChars[i]
            let nc = nameChars[start + i]

            if CONSONANT_JAMO.contains(qc) {
                guard initialOf(nc) == qc else { continue outer }
            } else if VOWEL_JAMO.contains(qc) {
                guard String(nc).searchFolded == String(qc).searchFolded else { continue outer }
            } else if let qd = decompose(qc), let nd = decompose(nc) {
                let choOK = qd.cho == nd.cho
                let jungOK = qd.jung == nd.jung
                let jongOK = (qd.jong == 0) || (qd.jong == nd.jong)
                guard choOK && jungOK && jongOK else { continue outer }
            } else {
                guard String(nc).searchFolded == String(qc).searchFolded else { continue outer }
            }
        }
        return true
    }

    return false
}
