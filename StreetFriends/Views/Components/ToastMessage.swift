//
//  ToastMessage.swift
//  StreetFriends
//
//  Created by kimhyojeong on 11/6/26.
//

import SwiftUI

struct ToastMessage: View {
    enum Kind: Equatable {
        case registerCat(name: String)
        case addEncounter(name: String)
    }
    
    let kind: Kind
    
    private var message: String {
        switch kind {
        case .registerCat(let name):
            return "\(name)\(name.eulReul) 친구로 등록했어요"
        case .addEncounter(let name):
            return "\(name)\(name.waGwa)의 추억을 쌓았어요"
        }
    }
    
    var body: some View {
        Text(message)
            .font(.pretendard(.medium, size: 16))
            .foregroundStyle(.netural20)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, minHeight: 64)
            .background(.blue60, in: RoundedRectangle(cornerRadius: 8))
            .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
            .padding(.horizontal, 50)
    }
}

#Preview {
    ToastMessage(kind: .registerCat(name: "찐빵이"))
    ToastMessage(kind: .addEncounter(name: "콩나물"))
    ToastMessage(kind: .registerCat(name: "여덟글자의고양이"))
}
