//
//  CatNameInputView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/29/25.
//

import SwiftUI

struct CatNameInputView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                Image(.imgBackground)
                    .resizable()
                    .scaledToFill()
                    .frame(height: proxy.size.height + proxy.safeAreaInsets.top + proxy.safeAreaInsets.bottom)
                    .ignoresSafeArea()
                    .ignoresSafeArea(.keyboard)
            } //: GEOMETRY
            
            VStack(spacing: 0) {
                NavigationBar(title: "추억쌓기",
                              style: .clear,
                              leading: { Button { dismiss() } label: { Image(.chevronLeft) } },
                              trailing: {})
                
                VStack(spacing: 0)  {
                    Text("새로운 친구의 이름은?")
                        .foregroundStyle(.white)
                        .font(.pretendard(.semiBold, size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 40)
                    
                    AppTextField(
                        text: $name,
                        placeholder: "이름을 입력하세요.",
                        autofocus: true,
                        returnKeyType: .next
                    ) {  }
                        .padding(10)
                        .frame(height: 44)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.top, 20)
                    
                    Spacer()
                } //: 콘텐츠 VSTACK
                .padding(.horizontal, 20)
            } //: 전체 VSTACK
        } //: ZSTACK
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CatNameInputView()
}
