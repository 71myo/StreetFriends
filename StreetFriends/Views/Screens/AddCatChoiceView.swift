//
//  AddCatChoiceView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/29/25.
//

import SwiftUI

struct AddCatChoiceView: View {
    @Environment(Router.self) private var router
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                Image(.imgBackground)
                    .resizable()
                    .scaledToFill()
                    .frame(height: proxy.size.height + proxy.safeAreaInsets.top + proxy.safeAreaInsets.bottom)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    NavigationBar(title: "추억쌓기",
                                  style: .clear,
                                  leading: { Button { dismiss() } label: { Image(.chevronLeft) } },
                                  trailing: {})
                    
                    VStack(spacing: 0) {
                        Text("어떤 친구를 만났나요?")
                            .foregroundStyle(.white)
                            .font(.pretendard(.semiBold, size: 24))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 40)
                        
                        Spacer()
                        
                        NavigationLink {
                            
                        } label: {
                            ZStack(alignment: .center) {
                                Image(.addOldFriend)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: proxy.size.width * 0.75)
                                
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
                                    .frame(width: proxy.size.width * 0.75)
                                
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
                } //: VSTACK
            } //: GEOMETRY
        } //: ZSTACK
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    AddCatChoiceView()
}
