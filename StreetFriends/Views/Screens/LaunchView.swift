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
                // 배경 이미지
                Image(.imgBackground)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                Image(.imgMountain)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 1.3)
                    .shadow(color: .black.opacity(0.10), radius: 2, x: 0, y: -2)
                    .offset(x: geometry.size.width * -0.2, y: geometry.size.height * 0.18)
                
                LaunchAssetView(geometry: geometry, imageName: "effectExclamation",
                                widthMultiplier: 0.045, xOffsetMultiplier: -0.44, yOffsetMultiplier: -0.72,
                                rotationDegrees: 3, isAnimating: $isAnimating)

                LaunchAssetView(geometry: geometry, imageName: "imgCat1",
                                widthMultiplier: 0.65, xOffsetMultiplier: -0.48, yOffsetMultiplier: -0.59,
                                rotationDegrees: 3, isAnimating: $isAnimating)

                LaunchAssetView(geometry: geometry, imageName: "effectBrackets",
                                widthMultiplier: 0.45, xOffsetMultiplier: 0.1, yOffsetMultiplier: -0.52,
                                rotationDegrees: -3, isAnimating: $isAnimating)

                LaunchAssetView(geometry: geometry, imageName: "imgCat2",
                                widthMultiplier: 0.65, xOffsetMultiplier: 0.19, yOffsetMultiplier: -0.58,
                                rotationDegrees: -3, isAnimating: $isAnimating)
                
                LaunchAssetView(geometry: geometry, imageName: "imgStreetText",
                                widthMultiplier: 0.65, xOffsetMultiplier: -0.25, yOffsetMultiplier: -0.35,
                                rotationDegrees: 1, isAnimating: $isAnimating)
                
                LaunchAssetView(geometry: geometry, imageName: "imgFriendsText",
                                widthMultiplier: 0.6, xOffsetMultiplier: 0, yOffsetMultiplier: -0.25,
                                rotationDegrees: 1, isAnimating: $isAnimating)
                
                LaunchAssetView(geometry: geometry, imageName: "imgCat3",
                                widthMultiplier: 0.5, xOffsetMultiplier: -0.4, yOffsetMultiplier: -0.21,
                                rotationDegrees: 3, isAnimating: $isAnimating)
                
                LaunchAssetView(geometry: geometry, imageName: "effectZz",
                                widthMultiplier: 0.07, xOffsetMultiplier: -0.55, yOffsetMultiplier: -0.15,
                                rotationDegrees: 3, isAnimating: $isAnimating)
                
                LaunchAssetView(geometry: geometry, imageName: "imgCat4",
                                widthMultiplier: 0.6, xOffsetMultiplier: -0.48, yOffsetMultiplier: 0.1,
                                rotationDegrees: 3, isAnimating: $isAnimating)
                
                LaunchAssetView(geometry: geometry, imageName: "effectWave",
                                widthMultiplier: 0.1, xOffsetMultiplier: -0.18, yOffsetMultiplier: 0.15,
                                rotationDegrees: 3, isAnimating: $isAnimating)
                
                LaunchAssetView(geometry: geometry, imageName: "imgCat5",
                                widthMultiplier: 0.8, xOffsetMultiplier: 0.12, yOffsetMultiplier: 0.19,
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
