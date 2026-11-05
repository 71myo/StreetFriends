//
//  ToastCenter.swift
//  StreetFriends
//
//  Created by kimhyojeong on 11/6/26.
//

import Foundation
import Observation

@MainActor
@Observable
final class ToastCenter {
    struct Item: Identifiable, Equatable {
        let id = UUID()
        let kind: ToastMessage.Kind
    }
    
    private(set) var current: Item?
    private var hideTask: Task<Void, Never>?

    func show(_ kind: ToastMessage.Kind, duration: Duration = .seconds(2)) {
        hideTask?.cancel() // 이전 토스트의 타이머 취소
        current = Item(kind: kind)

        hideTask = Task {
            try? await Task.sleep(for: duration)
            guard !Task.isCancelled else { return }
            current = nil // 2초 뒤 숨기기
        }
    }
}
