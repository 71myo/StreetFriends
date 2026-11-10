//
//  EmptyCatView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/28/25.
//

import SwiftUI

struct EmptyCatView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .bottom, spacing: 8.5) {
                Text("또는 버튼 누르기")
                    .font(.pretendard(.medium, size: 18))
                    .foregroundStyle(.netural50)
                    .offset(y: 8)
                
                Image(.arrowToPlus)
                    .renderingMode(.template)
                    .foregroundStyle(.netural40)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, 11)
            
            Spacer()
            
            Image(.mysteryCat)
                .resizable()
                .scaledToFit()
                .frame(width: 142, height: 142)
            
            Text("화면을 왼쪽으로 당겨\n친구를 추가해 보세요.")
                .font(.pretendard(.medium, size: 18))
                .foregroundStyle(.netural50)
                .padding(.top, 26)
            
            Spacer()
            Spacer()
        }
        .padding(.horizontal, 20)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("아직 등록한 친구가 없어요. 추억쌓기 버튼을 눌러 친구를 추가해 보세요.")
    }
}

#Preview {
    EmptyCatView()
}
