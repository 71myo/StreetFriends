//
//  CatSquareView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/27/25.
//

import SwiftUI

enum CatSquareType {
    case standard
    case favorite(isOn: Bool, action: () -> Void)
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
                        Image(.sampleCat) // fallback
                            .resizable()
                            .scaledToFill()
                    }
                }
            )
            .overlay(alignment: .topTrailing) {
                if case let .favorite(isOn, action) = type {
                    Button {
                        withAnimation { action() }
                    } label: {
                        Image(isOn ? .selectTrue : .selectFalse)
                    }
                    .offset(x: -5, y: 5)
                }
            }            
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    CatSquareView(catImageData: nil, type: .favorite(isOn: true, action: {}))
        .frame(height: 130)
}
