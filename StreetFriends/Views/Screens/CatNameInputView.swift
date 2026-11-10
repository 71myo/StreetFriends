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
                .dimmedForIncreasedContrast()
            
            ScrollView {
                VStack(spacing: 20)  {
                    Text("새로운 친구의 이름은?")
                        .foregroundStyle(.white)
                        .font(.pretendard(.semiBold, size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true) // 세로로 줄이지 않기
                    
                    AppInputField(
                        text: $name,
                        placeholder: "\(Cat.nameMaxLength)글자 이하의 이름을 입력하세요.",
                        maxLength: Cat.nameMaxLength,
                        externalFocus: $nameFocused) { _ in }
                        .padding(10)
                        .frame(minHeight: 44)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } //: 콘텐츠 VSTACK
                .padding(.horizontal, 20)
                .padding(.vertical, 40)
                .contentShape(Rectangle())
                .onTapGesture { nameFocused = false }
            } //: ScrollView
            .scrollBounceBehavior(.basedOnSize) // 내용이 화면보다 작으면 튕기지 않게 함
        } //: ZSTACK
        .safeAreaInset(edge: .top) {
            NavigationBar(title: "추억쌓기",
                          style: .clear,
                          leading: {
                Button { router.pop() }
                label: { Image(.chevronLeft).barIconTapArea() }
                    .barIconAccessibility("뒤로 가기", image: .chevronLeft)
            },
                          trailing: {})
        }
        .safeAreaInset(edge: .bottom) {
            PrimaryButton(kind: .next, isEnabled: canGoNext) {
                router.push(.encounterInput(catName: trimmedName))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
        }
        .onAppear {
            name = trimmedName
        }
    }
}

#Preview {
    CatNameInputView()
        .environment(Router())
}
