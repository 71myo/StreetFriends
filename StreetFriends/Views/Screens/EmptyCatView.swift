//
//  EmptyCatView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/28/25.
//

import SwiftUI

struct EmptyCatView: View {
    var body: some View {
        ZStack {
            Background()
            
            VStack(spacing: 0) {
                HStack(alignment: .bottom, spacing: 8.5) {
                    Text("또는 버튼 누르기")
                        .font(.pretendard(.medium, size: 18))
                        .foregroundStyle(.netural40)
                        .offset(y: 8)
                    
                    Image(.arrowToPlus)
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
                    .foregroundStyle(.netural40)
                    .padding(.top, 26)
                
                Spacer()
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .safeAreaInset(edge: .top) {
            NavigationBar(
                title: "친구들",
                leading: {},
                trailing: {
                    HStack(spacing: 12) {
                        Button { } label: {Image(.search)}
                        Button { } label: {Image(.addCatData)}
                    }
                }
            )
        }
    }
}

#Preview {
    EmptyCatView()
}
