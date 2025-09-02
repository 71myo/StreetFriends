//
//  PrimaryButton.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/30/25.
//

import SwiftUI

enum AppPrimaryButtonKind {
    case next
    case save
    
    var title: String {
        switch self {
        case .next:
            return "다음"
        case .save:
            return "저장하기"
        }
    }
    
    var colors: (bg: Color, pressed: Color, disabled: Color, text: Color, disabledText: Color) {
        switch self {
        case .next:
            return (bg: .blue10, pressed: .blue30, disabled: .netural30,
                    text: .netural80, disabledText: .netural20)
        case .save:
            return (bg: .blue50, pressed: .blue70, disabled: .netural30,
                    text: .blue90,  disabledText: .netural20)
        }
    }
}

struct AppPrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    let normalBG: Color
    let pressedBG: Color
    let disabledBG: Color
    let normalFG: Color
    let disabledFG: Color

    func makeBody(configuration: Configuration) -> some View {
        let bg = isEnabled ? (configuration.isPressed ? pressedBG : normalBG) : disabledBG
        let fg = isEnabled ? normalFG : disabledFG

        return configuration.label
            .font(.pretendard(.semiBold, size: 18))
            .foregroundStyle(fg)
            .frame(maxWidth: .infinity, minHeight: 54)
            .background(bg)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}


struct PrimaryButton: View {
    let kind: AppPrimaryButtonKind
    var isEnabled: Bool = true
    var action: () -> Void
    
    var body: some View {
        let c = kind.colors
        Button(kind.title, action: action)
            .buttonStyle(AppPrimaryButtonStyle(
                normalBG: c.bg,
                pressedBG: c.pressed,
                disabledBG: c.disabled,
                normalFG: c.text,
                disabledFG: c.disabledText
            ))
            .disabled(!isEnabled)
            .contentShape(RoundedRectangle(cornerRadius: 8))
            .accessibilityLabel(kind.title)
    }
}

#Preview("다음") {
    PrimaryButton(kind: .next, action: {})
}

#Preview("저장") {
    PrimaryButton(kind: .save, action: {})
}
