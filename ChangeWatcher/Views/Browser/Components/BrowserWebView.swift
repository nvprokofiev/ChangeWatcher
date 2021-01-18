//
//  WebView.swift
//  UpdatesWatcher
//
//  Created by Nikolai Prokofev on 2020-09-20.
//

import SwiftUI
import WebKit

public struct BrowserWebView: View, UIViewRepresentable {
    
    public let webView: WKWebView
    
    public typealias UIViewType = UIViewContainerView<WKWebView>
    
    public init(webView: WKWebView) {
        self.webView = webView
    }
    
    public func makeUIView(context: UIViewRepresentableContext<BrowserWebView>) -> BrowserWebView.UIViewType {
        return UIViewContainerView()
    }
    
    public func updateUIView(_ uiView: BrowserWebView.UIViewType, context: UIViewRepresentableContext<BrowserWebView>) {
        if uiView.contentView !== webView {
            uiView.contentView = webView
        }
    }
}
