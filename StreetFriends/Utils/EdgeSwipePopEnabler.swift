//
//  EdgeSwipePopEnabler.swift
//  StreetFriends
//
//  Created by Hyojeong on 12/12/25.
//

import SwiftUI

struct EdgeSwipePopEnabler: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = UIViewController()
        DispatchQueue.main.async {
            guard let nav = vc.navigationController,
                  let pop = nav.interactivePopGestureRecognizer else { return }
            pop.isEnabled = true
            pop.delegate = nil // 디폴트 제스처 델리게이트 해제 → 다시 동작
        }
        return vc
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
