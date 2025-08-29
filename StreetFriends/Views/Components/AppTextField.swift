//
//  AppTextField.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/29/25.
//

import SwiftUI
import UIKit

struct AppTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String = ""
    var autofocus: Bool = false
    var returnKeyType: UIReturnKeyType = .default // .search, .next(CatName)
    var fontSize: CGFloat = 18
    var onSubmit: () -> Void = {}
    
    func makeUIView(context: Context) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.returnKeyType = returnKeyType
        tf.enablesReturnKeyAutomatically = true    // 입력 없으면 리턴키 회색 비활성화
        tf.clearButtonMode = .whileEditing                // 시스템 X 버튼 비활성화
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.autocapitalizationType = .none

        tf.font = UIFont(name: "Pretendard-Regular", size: fontSize)
        tf.textColor = .netural80
        tf.tintColor = .blue50
        
        tf.addTarget(context.coordinator, action: #selector(Coordinator.textChanged), for: .editingChanged)
        tf.delegate = context.coordinator

        if autofocus {
            DispatchQueue.main.async { tf.becomeFirstResponder() } // 자동 포커스
        }
        return tf
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        if uiView.text != text { uiView.text = text }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, onSubmit: onSubmit)
    }

    final class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        var onSubmit: () -> Void
        init(text: Binding<String>, onSubmit: @escaping () -> Void) {
            _text = text; self.onSubmit = onSubmit
        }
        @objc func textChanged(_ sender: UITextField) { text = sender.text ?? "" }
        func textFieldShouldReturn(_ tf: UITextField) -> Bool {
            guard !(tf.text ?? "").isEmpty else { return false } // 비어있으면 submit 막기
            onSubmit()
            return true
        }
    }
}
