//
//  CatSquareView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/27/25.
//

import SwiftUI

enum CatSquareType {
    case standard
    case favorite(isOn: Bool, name: String, action: () -> Void)
}

struct CatSquareView: View {
    // MARK: - PROPERTIES
    let catImageData: Data?
    let type: CatSquareType
    var cornerRadius: CGFloat = 8
    
    private var isFavoriteType: Bool {
        if case .favorite = type { return true }
        return false
    }
    
    private var favoriteValue: String {
        if case let .favorite(isOn, _, _) = type, isOn { return "즐겨찾는 친구" }
        return ""
    }
    
    // MARK: - BODY
    var body: some View {
        Color.clear
            .aspectRatio(1, contentMode: .fit)
            .overlay(
                DataImage(data: catImageData) { img in
                    img.resizable().scaledToFill()
                }
            )
            .overlay {
                if isFavoriteType {
                    LinearGradient(colors: [.clear, .black.opacity(0.4)],
                                   startPoint: .top, endPoint: .bottom)
                }
            }
            .overlay(alignment: .topTrailing) {
                if case let .favorite(isOn, _, action) = type {
                    Button {
                        Haptic.favoriteToggled()
                        withAnimation { action() }
                    } label: {
                        Image(isOn ? .selectTrue : .selectFalse)
                    }
                    .accessibilityHidden(true)
                    .offset(x: -5, y: 5)
                }
            }
            .overlay(alignment: .bottomLeading) {
                if case let .favorite(_, name, _) = type {
                    Text(name)
                        .font(.pretendard(.medium, size: 16))
                        .foregroundStyle(.white)
                        .offset(x: 5, y: -5)
                        .dynamicTypeSize(...DynamicTypeSize.xxLarge)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .accessibilityElement(children: .combine)
            .accessibilityValue(favoriteValue)
    }
}

#Preview {
    CatSquareView(catImageData: nil, type: .favorite(isOn: true, name: "찐빵이", action: {}))
        .frame(height: 130)
}
