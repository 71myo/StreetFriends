//
//  LaunchAssetView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/15/25.
//

import SwiftUI

struct LaunchAssetView: View {
    // MARK: - PROPERTIES
    let geometry: GeometryProxy
    let imageName: String
    let widthMultiplier: CGFloat
    let xOffsetMultiplier: CGFloat
    let yOffsetMultiplier: CGFloat
    let rotationDegrees: Double
    @Binding var isAnimating: Bool
    
    // MARK: - BODY
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: geometry.size.width * widthMultiplier)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
            .rotationEffect(.degrees(isAnimating ? rotationDegrees : -rotationDegrees))
            .animation(
                .easeInOut(duration: 0.3).repeatCount(5),
                value: isAnimating
            )
            .offset(
                x: geometry.size.width * xOffsetMultiplier,
                y: geometry.size.height * yOffsetMultiplier
            )
    }
}

#Preview {
    GeometryReader { geometry in
        LaunchAssetView(geometry: geometry,
                        imageName: "imgCat1",
                        widthMultiplier: 0.5,
                        xOffsetMultiplier: 0,
                        yOffsetMultiplier: 0,
                        rotationDegrees: 15,
                        isAnimating: .constant(true))
    }
}
