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
        GeometryReader { geometry in
            ZStack {
                Image(.imgBackground)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                LaunchAssetView(geometry: geometry, imageName: "effectExclamation",
                                widthMultiplier: 0.045, xOffsetMultiplier: -0.3, yOffsetMultiplier: -0.55,
                                rotationDegrees: 3, isAnimating: $isAnimating)

                LaunchAssetView(geometry: geometry, imageName: "imgCat1",
                                widthMultiplier: 0.65, xOffsetMultiplier: -0.35, yOffsetMultiplier: -0.42,
                                rotationDegrees: 3, isAnimating: $isAnimating)

                LaunchAssetView(geometry: geometry, imageName: "effectBrackets",
                                widthMultiplier: 0.45, xOffsetMultiplier: 0.27, yOffsetMultiplier: -0.33,
                                rotationDegrees: -3, isAnimating: $isAnimating)

                LaunchAssetView(geometry: geometry, imageName: "imgCat2",
                                widthMultiplier: 0.65, xOffsetMultiplier: 0.35, yOffsetMultiplier: -0.4,
                                rotationDegrees: -3, isAnimating: $isAnimating)
                
                LaunchAssetView(geometry: geometry, imageName: "imgStreetText",
                                widthMultiplier: 0.65, xOffsetMultiplier: -0.1, yOffsetMultiplier: -0.15,
                                rotationDegrees: 1, isAnimating: $isAnimating)
                
                LaunchAssetView(geometry: geometry, imageName: "imgFriendsText",
                                widthMultiplier: 0.6, xOffsetMultiplier: 0.14, yOffsetMultiplier: -0.05,
                                rotationDegrees: 1, isAnimating: $isAnimating)
                
                LaunchAssetView(geometry: geometry, imageName: "imgCat3",
                                widthMultiplier: 0.48, xOffsetMultiplier: -0.25, yOffsetMultiplier: -0.01,
                                rotationDegrees: 3, isAnimating: $isAnimating)
                
                LaunchAssetView(geometry: geometry, imageName: "effectZz",
                                widthMultiplier: 0.07, xOffsetMultiplier: -0.4, yOffsetMultiplier: 0.06,
                                rotationDegrees: 3, isAnimating: $isAnimating)
                
                LaunchAssetView(geometry: geometry, imageName: "imgCat4",
                                widthMultiplier: 0.6, xOffsetMultiplier: -0.33, yOffsetMultiplier: 0.27,
                                rotationDegrees: 3, isAnimating: $isAnimating)
                
                LaunchAssetView(geometry: geometry, imageName: "effectWave",
                                widthMultiplier: 0.1, xOffsetMultiplier: -0.03, yOffsetMultiplier: 0.33,
                                rotationDegrees: 3, isAnimating: $isAnimating)
                
                LaunchAssetView(geometry: geometry, imageName: "imgCat5",
                                widthMultiplier: 0.77, xOffsetMultiplier: 0.27, yOffsetMultiplier: 0.37,
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
