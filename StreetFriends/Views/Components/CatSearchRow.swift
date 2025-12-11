//
//  CatSearchView.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/1/25.
//

import SwiftUI

struct CatSearchRow: View {
    let cat: Cat // text
    let query: String // highlightText
    
    var body: some View {
        HStack(spacing: 14) {
            CatSquareView(catImageData: cat.profilePhoto, type: .standard)
                .frame(width: 44, height: 44)
            
            Text(cat.name)
                .font(.pretendard(.regular, size: 14))
                .foregroundStyle(.netural60)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 24)
    }
}

#Preview {
    CatSearchRow(cat: .previewOne, query: "빵")
}
