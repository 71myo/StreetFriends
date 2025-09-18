//
//  Background.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/2/25.
//

import SwiftUI

struct Background: View {
    let image: ImageResource
    
    init(_ image: ImageResource = .homeBackground) {
        self.image = image
    }
    
    var body: some View {
        GeometryReader { proxy in
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: proxy.size.width, height: proxy.size.height + proxy.safeAreaInsets.top + proxy.safeAreaInsets.bottom)
                .ignoresSafeArea(.all)
                .ignoresSafeArea(.keyboard)
        } //: GEOMETRY
    }
}

#Preview {
    Background()
}
