//
//  DarkBlurView.swift
//  KeepingWinner
//
//  Created by 유지수 on 3/21/25.
//

import SwiftUI
import UIKit

struct DarkBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark) // 가장 옅은 블러
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurView
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

