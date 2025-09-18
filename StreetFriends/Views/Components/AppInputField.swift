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
    var maxLength: Int? = nil
    var fontSize: CGFloat = 18
    var autoFocus: Bool = true
    var externalFocus: FocusState<Bool>.Binding? // 넘기는 거 없으면 내부 포커스 사용
    var onSubmit: (String) -> Void
    
    @FocusState private var internalFocus: Bool
    private var appliedFocus: FocusState<Bool>.Binding {
        externalFocus ?? $internalFocus
    }
    
    // MARK: - BODY
    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .focused(appliedFocus)
                .submitLabel(submitLabel)
                .onChange(of: text) { oldValue, newValue in
                    guard let max = maxLength, newValue.count > max else { return }
                    text = String(newValue.prefix(max))
                }
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .tint(.green60)
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
        .task { if autoFocus { appliedFocus.wrappedValue = true } }
    }
}
