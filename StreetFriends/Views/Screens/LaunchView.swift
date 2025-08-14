//
//  LaunchView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/15/25.
//

import SwiftUI

struct LaunchView: View {
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
                    .offset(x: geometry.size.width * -0.2, y: geometry.size.height * 0.18)
                
                Image(.effectExclamation)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.045)
                    .offset(x: geometry.size.width * -0.44, y: geometry.size.height * -0.72)

                Image(.imgCat1)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.65)
                    .offset(x: geometry.size.width * -0.48, y: geometry.size.height * -0.59)

                Image(.effectBrackets)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.45)
                    .offset(x: geometry.size.width * 0.1, y: geometry.size.height * -0.52)

                Image(.imgCat2)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.65)
                    .offset(x: geometry.size.width * 0.19, y: geometry.size.height * -0.58)

                Image(.imgStreetText)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.65)
                    .offset(x: geometry.size.width * -0.25, y: geometry.size.height * -0.35)

                Image(.imgFriendsText)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.6)
                    .offset(y: geometry.size.height * -0.25)
                
                Image(.imgCat3)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.5)
                    .offset(x: geometry.size.width * -0.4, y: geometry.size.height * -0.21)
                
                Image(.effectZz)
                    .offset(x: geometry.size.width * -0.55, y: geometry.size.height * -0.15)
                
                Image(.imgCat4)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.6)
                    .offset(x: geometry.size.width * -0.48, y: geometry.size.height * 0.1)
                
                Image(.effectWave)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.1)
                    .offset(x: geometry.size.width * -0.18, y: geometry.size.height * 0.15)
                
                Image(.imgCat5)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.8)
                    .offset(x: geometry.size.width * 0.12, y: geometry.size.height * 0.19)
            }
        }
    }
}

#Preview {
    LaunchView()
}
