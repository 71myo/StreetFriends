//
//  DuplicatedNameNotice.swift
//  StreetFriends
//
//  Created by kimhyojeong on 11/10/26.
//

import SwiftUI

struct DuplicateNameNotice: View {
    enum Style {
        case input
        case edit
    }
    
    static let message: String = "이미 사용 중인 이름이에요."
    
    var style: Style = .input
    
    var body: some View {
        switch style {
        case .input:
            content
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(Color.blue10, in: RoundedRectangle(cornerRadius: 8))
        case .edit:
            content
        }
    }
    
    // MARK: - 공통 내용
    private var content: some View {
        HStack(spacing: 2) {
            Image(.error)
            Text(Self.message)
                .font(.pretendard(.regular, size: 14))
        }
        .foregroundStyle(.redError)
        .frame(maxWidth: .infinity, alignment: .leading)
        .onAppear {
            AccessibilityNotification.Announcement(Self.message).post()
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        DuplicateNameNotice(style: .input)
        DuplicateNameNotice(style: .edit)
    }
}
