//
//  NoteEditorCard.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/1/25.
//

import SwiftUI

struct NoteEditorCard: View {
    @Binding var text: String
    var placeholder: String = "친구와의 만남을 기록해보세요."
    var maxCount: Int = 150
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
            
            VStack(alignment: .leading, spacing: 0) {
                TextEditor(text: $text)
                    .font(.pretendard(.regular, size: 16))
                    .foregroundStyle(.netural80)
                    .autocorrectionDisabled()
                    .tint(.blue50)
                    .overlay(alignment: .topLeading) {
                        Text(placeholder)
                            .foregroundStyle(text.isEmpty ? .netural50 : .clear)
                            .font(.pretendard(.regular, size: 16))
                            .offset(x: 5, y: 8)
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
                    .foregroundStyle(.netural40)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 11)
                    .padding(.bottom, 8)
            }
        }
    }
}

#Preview {
    NoteEditorCard(text: .constant("프리뷰 노트"))
}
