//
//  NoteEditorCard.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/1/25.
//

import SwiftUI

struct NoteEditorCard: View {
    @Binding var text: String
    var isFocused: FocusState<Bool>.Binding
    var placeholder: String = "친구와의 추억을 남겨 보세요."
    var maxCount: Int = 150
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
            
            VStack(alignment: .leading, spacing: 0) {
                TextEditor(text: $text)
                    .focused(isFocused)
                    .font(.pretendard(.regular, size: 16))
                    .foregroundStyle(.netural80)
                    .autocorrectionDisabled()
                    .tint(.blue50)
                    .accessibilityLabel("친구 일지")
                    .accessibilityHint(text.isEmpty ? placeholder : "")
                    .accessibilityAction(named: "키보드 내리기") {
                        isFocused.wrappedValue = false
                    }
                    .overlay(alignment: .topLeading) {
                        Text(placeholder)
                            .foregroundStyle(text.isEmpty ? .netural50 : .clear)
                            .font(.pretendard(.regular, size: 16))
                            .offset(x: 5, y: 8)
                            .accessibilityHidden(true)
                    }
                    .padding(.top, 12)
                    .padding(.horizontal, 12)
                    .onChange(of: text) { _, new in
                        if new.count > maxCount {
                            text = String(new.prefix(maxCount))
                        }
                    }
                                                
                // TEXTEDITOR 우측 하단 글자 수 표기
                Text("\(text.count)/\(maxCount)")
                    .font(.pretendard(.medium, size: 12))
                    .foregroundStyle(.netural50)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 11)
                    .padding(.bottom, 8)
                    .accessibilityLabel("\(maxCount)자 중 \(text.count)자")
            }
        }
    }
}

#Preview {
    @Previewable @State var text = "프리뷰 노트"
    @Previewable @FocusState var isFocused: Bool
    NoteEditorCard(text: $text, isFocused: $isFocused)
}
