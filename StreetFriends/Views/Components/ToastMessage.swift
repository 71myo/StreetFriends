//
//  ToastMessage.swift
//  StreetFriends
//
//  Created by kimhyojeong on 11/6/26.
//

import SwiftUI

struct ToastMessage: View {
    let name: String
    let message: String = "을 친구로 등록했어요"
    
    var body: some View {
        HStack(spacing: 0) {
            Text(name)
            Text(message)
        }
        .font(.pretendard(.medium, size: 16))
        .foregroundStyle(.netural20)
        .frame(maxWidth: .infinity)
        .frame(height: 64)
        .background(.blue60, in: RoundedRectangle(cornerRadius: 8))
        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
        .padding(.horizontal, 50)
    }
}

#Preview {
    ToastMessage(name: "찐빵이")
}
