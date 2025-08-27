//
//  CatSquareView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/27/25.
//

import SwiftUI

enum CatSquareType {
    case standard
    case favorite(isFavorite: Binding<Bool>)
}

struct CatSquareView: View {
    // MARK: - PROPERTIES
    let catImage: UIImage
    let type: CatSquareType
    
    // MARK: - BODY
    var body: some View {
        Color.clear
            .aspectRatio(1, contentMode: .fit)
            .overlay(
                Image(uiImage: catImage)
                    .resizable()
                    .scaledToFill()
            )
            .overlay(alignment: .topTrailing) {
                if case .favorite(let isFavorite) = type {
                    Button {
                        withAnimation {
                            isFavorite.wrappedValue.toggle()
                        }
                    } label: {
                        Image(isFavorite.wrappedValue ? .selectTrue : .selectFalse)
                    }
                    .offset(x: -5, y: 5)
                }
            }            
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    CatSquareView(catImage: .sampleCat, type: .favorite(isFavorite: .constant(true)))
        .frame(height: 130)
}
