//
//  CatsGridView.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/1/25.
//

import SwiftUI

struct CatsGridView<Destination: View>: View {
    // MARK: - PROPERTIES
    let cats: [Cat]
    var columns: Int = 3
    var spacing: CGFloat = 4
    let destination: (Cat) -> Destination
    let onToggleFavorite: (Cat) -> Void
    
    private var gridItems: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: spacing), count: columns)
    }
    
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: spacing) {
            ForEach(cats) { cat in
                NavigationLink {
                    destination(cat)
                } label: {
                    CatSquareView(
                        catImageData: cat.profilePhoto,
                        type: .favorite(
                            isOn: cat.isFavorite,
                            name: cat.name,
                            action: { onToggleFavorite(cat) }
                        )
                    )
                }
            }
        }
    }
}

#Preview {
    CatsGridView(cats: [.previewOne, .previewTwo, .previewThree], destination: { _ in EmptyView()}, onToggleFavorite: { _ in })
}
