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
    @State private var name: String = ""
    private var trimmedName: String { name.trimmingCharacters(in: .whitespacesAndNewlines) }
    private var canGoNext: Bool { !trimmedName.isEmpty }
    @FocusState private var nameFocused: Bool
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .top) {
            Background(.imgBackground)
            
            VStack(spacing: 0)  {
                Text("새로운 친구의 이름은?")
                    .foregroundStyle(.white)
                    .font(.pretendard(.semiBold, size: 24))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 40)
                
                AppInputField(
                    text: $name,
                    placeholder: "8글자 이하의 이름을 입력하세요.",
                    maxLength: 8,
                    externalFocus: $nameFocused) { _ in }
                    .padding(10)
                    .frame(height: 44)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.top, 20)
            } //: 콘텐츠 VSTACK
            .padding(.bottom, 12)
            .contentShape(Rectangle())
            .onTapGesture { nameFocused = false }
        } //: ZSTACK
        .safeAreaInset(edge: .top) {
            NavigationBar(title: "추억쌓기",
                          style: .clear,
                          leading: { Button { router.pop() } label: { Image(.chevronLeft) } },
                          trailing: {})
        }
        .safeAreaInset(edge: .bottom) {
            PrimaryButton(kind: .next, isEnabled: canGoNext) {
                router.push(.encounterInput(catName: trimmedName))
            }
        }
        .padding(.horizontal, 20)
        .onAppear {
            name = trimmedName
        }
    }
}

#Preview {
    CatNameInputView()
        .environment(Router())
}
