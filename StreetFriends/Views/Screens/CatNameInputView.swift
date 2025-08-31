//
//  CatNameInputView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/29/25.
//

import SwiftUI

struct CatNameInputView: View {
    // MARK: - PROPERTIES
    @Environment(Router.self) private var router
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    private var trimmedName: String {
        name.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    private var canGoNext: Bool { !trimmedName.isEmpty }
    // MARK: - BODY
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
                    
                    AppInputField(
                        text: $name,
                        placeholder: "8글자 이하의 이름을 입력하세요.",
                        maxLength: 8) { _ in }
                    .padding(10)
                    .frame(height: 44)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.top, 20)
                    
                    Spacer()

                    PrimaryButton(kind: .next, isEnabled: canGoNext) {
                        router.push(.encounterInput(catName: trimmedName))
                    }
                } //: 콘텐츠 VSTACK
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
            } //: 전체 VSTACK
        } //: ZSTACK
        .navigationBarBackButtonHidden()
        .onAppear {
            name = trimmedName
        }
    }
}

#Preview {
    CatNameInputView()
        .environment(Router())
}
