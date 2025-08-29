//
//  LaunchView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/15/25.
//

import SwiftUI

struct LaunchView: View {
    @State private var isAnimating = false
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Image(.imgBackground)
                    .resizable()
                    .scaledToFill()
                    .frame(height: proxy.size.height + proxy.safeAreaInsets.top + proxy.safeAreaInsets.bottom)
                    .ignoresSafeArea()
                
                LaunchAssetView(geometry: proxy, imageName: "effectExclamation",
                                widthMultiplier: 0.045, xOffsetMultiplier: -0.3, yOffsetMultiplier: -0.57,
                                rotationDegrees: 3, isAnimating: $isAnimating)

                LaunchAssetView(geometry: proxy, imageName: "imgCat1",
                                widthMultiplier: 0.65, xOffsetMultiplier: -0.35, yOffsetMultiplier: -0.44,
                                rotationDegrees: 3, isAnimating: $isAnimating)

                LaunchAssetView(geometry: proxy, imageName: "effectBrackets",
                                widthMultiplier: 0.45, xOffsetMultiplier: 0.27, yOffsetMultiplier: -0.35,
                                rotationDegrees: -3, isAnimating: $isAnimating)

                LaunchAssetView(geometry: proxy, imageName: "imgCat2",
                                widthMultiplier: 0.65, xOffsetMultiplier: 0.35, yOffsetMultiplier: -0.42,
                                rotationDegrees: -3, isAnimating: $isAnimating)
                
                LaunchAssetView(geometry: proxy, imageName: "imgStreetText",
                                widthMultiplier: 0.65, xOffsetMultiplier: -0.1, yOffsetMultiplier: -0.17,
                                rotationDegrees: 1, isAnimating: $isAnimating)
                
                LaunchAssetView(geometry: proxy, imageName: "imgFriendsText",
                                widthMultiplier: 0.6, xOffsetMultiplier: 0.14, yOffsetMultiplier: -0.08,
                                rotationDegrees: 1, isAnimating: $isAnimating)
                
                LaunchAssetView(geometry: proxy, imageName: "imgCat3",
                                widthMultiplier: 0.48, xOffsetMultiplier: -0.25, yOffsetMultiplier: -0.03,
                                rotationDegrees: 3, isAnimating: $isAnimating)
                
                LaunchAssetView(geometry: proxy, imageName: "effectZz",
                                widthMultiplier: 0.07, xOffsetMultiplier: -0.4, yOffsetMultiplier: 0.04,
                                rotationDegrees: 3, isAnimating: $isAnimating)
                
                LaunchAssetView(geometry: proxy, imageName: "imgCat4",
                                widthMultiplier: 0.6, xOffsetMultiplier: -0.33, yOffsetMultiplier: 0.25,
                                rotationDegrees: 3, isAnimating: $isAnimating)
                
                LaunchAssetView(geometry: proxy, imageName: "effectWave",
                                widthMultiplier: 0.1, xOffsetMultiplier: -0.03, yOffsetMultiplier: 0.31,
                                rotationDegrees: 3, isAnimating: $isAnimating)
                
                LaunchAssetView(geometry: proxy, imageName: "imgCat5",
                                widthMultiplier: 0.77, xOffsetMultiplier: 0.27, yOffsetMultiplier: 0.35,
                                rotationDegrees: 3, isAnimating: $isAnimating)
            } //: ZSTACK
            .onAppear {
                isAnimating.toggle()
            }
        } //: GEOMETRY
    }
}

#Preview {
    LaunchView()
}
