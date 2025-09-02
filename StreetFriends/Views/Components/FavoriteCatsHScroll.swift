//
//  FavoriteCatsHScroll.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/1/25.
//

import SwiftUI

struct FavoriteCatsHScroll: View {
    // MARK: - PROPERTIES
    let cats: [Cat]
    var itemHeight: CGFloat = 130
    var spacing: CGFloat = 4
    let onSelect: (Cat) -> Void
    let onToggleFavorite: (Cat) -> Void

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: spacing) {
                ForEach(cats) { cat in
                    Button {
                        onSelect(cat)
                    } label: {
                        CatSquareView(
                            catImageData: cat.profilePhoto,
                            type: .favorite(
                                isOn: cat.isFavorite,
                                name: cat.name,
                                action: { onToggleFavorite(cat) }
                            )
                        )
                        .frame(height: itemHeight)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    FavoriteCatsHScroll(cats: [.previewOne, .previewTwo, .previewThree], onSelect: {_ in }, onToggleFavorite: {_ in })
        .padding(.horizontal, 20)
}
