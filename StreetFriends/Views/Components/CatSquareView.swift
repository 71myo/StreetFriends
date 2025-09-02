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
    
    // MARK: - BODY
    var body: some View {
        Color.clear
            .aspectRatio(1, contentMode: .fit)
            .overlay(
                Group {
                    if let data = catImageData, let ui = UIImage(data: data) {
                        Image(uiImage: ui)
                            .resizable()
                            .scaledToFill()
                    } else {
                        Rectangle()
                            .foregroundStyle(.netural30)
                        
                        Image(.mysteryCat)
                            .resizable()
                            .scaledToFit()
                            .padding(10)
                    }
                }
            )
            .overlay(alignment: .topTrailing) {
                if case let .favorite(isOn, _, action) = type {
                    Button {
                        withAnimation { action() }
                    } label: {
                        Image(isOn ? .selectTrue : .selectFalse)
                    }
                    .offset(x: -5, y: 5)
                }
            }
            .overlay(alignment: .bottomLeading) {
                if case let .favorite(_, name, _) = type {
                    Text(name)
                        .font(.pretendard(.medium, size: 16))
                        .foregroundStyle(.white)
                        .offset(x: 5, y: -5)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    CatSquareView(catImageData: nil, type: .favorite(isOn: true, name: "찐빵이", action: {}))
        .frame(height: 130)
}
