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
    var accessibilityHintText: String = ""
    var onSubmit: (String) -> Void
    
    @FocusState private var internalFocus: Bool
    private var appliedFocus: FocusState<Bool>.Binding {
        externalFocus ?? $internalFocus
    }
    @ScaledMetric(relativeTo: .body) private var clearIconSize: CGFloat = 20
    
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
                .tint(.green70)
                .font(.pretendard(.regular, size: fontSize))
                .accessibilityHint(accessibilityHintText)
            
            Spacer()
            
            Button {
                text = ""
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: clearIconSize, height: clearIconSize)
                    .foregroundStyle(.netural30)
                    .frame(width: clearIconSize + 8, height: clearIconSize + 8) // 누르는 영역
                    .contentShape(Rectangle())
            }
            .accessibilityLabel("입력 내용 지우기")
            .opacity(text.isEmpty ? 0 : 1)
            .disabled(text.isEmpty)
            .accessibilityHidden(text.isEmpty)
        } //: HSTACK
        .task { if autoFocus { appliedFocus.wrappedValue = true } }
    }
}

// MARK: - 입력칸 테두리
extension View {
    /// 입력칸 테두리. isError가 true면 에러 색상으로 표시
    func inputFieldBorder(isError: Bool, cornerRadius: CGFloat = 8) -> some View {
        self.overlay {
            RoundedRectangle(cornerRadius: cornerRadius)
                .strokeBorder(isError ? Color.redError : Color.clear, lineWidth: 1)
        }
    }
}
