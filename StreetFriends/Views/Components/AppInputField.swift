//
//  AppInputField.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/30/25.
//

import SwiftUI

struct AppInputField: View {
    // MARK: - PROPERTIES
    @Binding var text: String
    var placeholder: String
    var submitLabel: SubmitLabel = .done
    var autoFocus: Bool = false
    var maxLength: Int? = nil
    var fontSize: CGFloat = 18
    var onSubmit: (String) -> Void
    
    @FocusState private var isFocused: Bool
    // MARK: - BODY
    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .focused($isFocused)
                .submitLabel(submitLabel)
                .onChange(of: text, { oldValue, newValue in
                    guard let max = maxLength, newValue.count > max else { return }
                    text = String(newValue.prefix(max))
                })
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .tint(.blue50)
                .font(.pretendard(.regular, size: fontSize))
            
            Spacer()
            
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.netural30)
                        .frame(width: 28, height: 28)
                }
            }
        } //: HSTACK
        .task { if autoFocus { isFocused = true }}
    }
}
