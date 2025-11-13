//
//  AddCatChoiceView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/29/25.
//

import SwiftUI

struct AddCatChoiceView: View {
    @Environment(Router.self) private var router
    
    var body: some View {
        ZStack {
            Background(.imgBackground)
            
            VStack(spacing: 0) {
                Text("어떤 친구를 만났나요?")
                    .foregroundStyle(.white)
                    .font(.pretendard(.semiBold, size: 24))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 40)
                
                Spacer()
                
                NavigationLink {
                    CatSelectView()
                } label: {
                    ZStack(alignment: .center) {
                        Image(.addOldFriend)
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 30)
                        
                        Text("만났던 친구")
                            .font(.pretendard(.medium, size: 20))
                            .foregroundStyle(.blue90)
                            .offset(x: -3, y: 5)
                    }
                }
                Spacer()
                
                Button {
                    router.push(.catNameInput)
                } label: {
                    ZStack(alignment: .center) {
                        Image(.addNewFriend)
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 30)
                        
                        Text("새로운 친구")
                            .font(.pretendard(.medium, size: 20))
                            .foregroundStyle(.green100)
                            .offset(x: 15, y: 5)
                    }
                }
                
                Spacer()
                Spacer()
            } //: 콘텐츠 VSTACK
            .padding(.horizontal, 20)
        } //: ZSTACK
        .safeAreaInset(edge: .top) {
            NavigationBar(title: "추억쌓기",
                          style: .clear,
                          leading: { Button { router.pop() } label: { Image(.chevronLeft) } },
                          trailing: {})
        }
    }
}

#Preview {
    AddCatChoiceView()
        .environment(Router())
}
