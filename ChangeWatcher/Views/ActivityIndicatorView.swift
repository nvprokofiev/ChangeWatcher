//
//  ActivityIndicatorView.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-02-11.
//

import Foundation
import SwiftUI

struct ActivityIndicatorView: View, UIViewRepresentable {
        
    @Binding var isAnimating: Bool

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        UIActivityIndicatorView(style: .medium)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
