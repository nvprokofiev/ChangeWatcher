//
//  WebViewStore.swift
//  UpdatesWatcher
//
//  Created by Nikolai Prokofev on 2020-09-28.
//

import SwiftUI
import WebKit
import Combine

protocol WebViewStoreDelegate: class {
    func onLongTap(with message: Any)
}

class WebViewStore: NSObject, ObservableObject {
    
    @Published var webView: WKWebView {
        didSet { setupObservers() }
    }
    
    private var observers: [NSKeyValueObservation] = []
    weak var delegate: WebViewStoreDelegate?
    
    override init() {
        self.webView = WKWebView()
        super.init()
        setupWebView()
        setupObservers()
    }
    
    deinit {
        observers.forEach {
            $0.invalidate()
        }
    }
    
    private func setupObservers() {
        func subscriber<Value>(for keyPath: KeyPath<WKWebView, Value>) -> NSKeyValueObservation {
            return webView.observe(keyPath, options: [.prior]) { _, change in
                if change.isPrior {
                    self.objectWillChange.send()
                }
            }
        }
        observers = [
            subscriber(for: \.title),
            subscriber(for: \.url),
            subscriber(for: \.isLoading),
            subscriber(for: \.estimatedProgress),
            subscriber(for: \.hasOnlySecureContent),
            subscriber(for: \.serverTrust),
            subscriber(for: \.canGoBack),
            subscriber(for: \.canGoForward)
        ]
    }
    
    private func setupWebView() {
        let configuration = WKWebViewConfiguration()
        
        WKUserScript.CustomScripts.allCases.forEach {
            configuration.add(script: $0, scriptMessageHandler: self)
        }

        webView = WKWebView(frame: .zero, configuration: configuration)
        webView.allowsLinkPreview = false
        webView.navigationDelegate = self
    }
}

extension WebViewStore: WKScriptMessageHandler  {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        guard let script = WKUserScript.CustomScripts(rawValue: message.name) else { return }
        
        switch script {
        case .longPressEvent:
            delegate?.onLongTap(with: message.body)
        default:
            return
        }
    }
}

extension WebViewStore: WKNavigationDelegate {

    
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//
//        guard let currentURL = currentURL else {
//            self.currentURL = webView.url!
//            decisionHandler(.allow)
//            return
//        }
//
//
//
//        if currentURL == webView.url {
//            //reload
//        }
//
//        if currentURL != webView.url! {
//
//            self.currentURL = webView.url!
//            decisionHandler(.cancel)
//            WebCacheCleaner.clean()
//            let request = URLRequest(url: webView.url!)
//            webView.load(request)
//        } else {
//            decisionHandler(.allow)
//        }
//    }
    
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.webView.evaluateJavaScript("document.documentElement.outerHTML.toString()",
//                                                    completionHandler: { (html: Any?, error: Error?) in
//                                                        print("\n\n\n\n\n\n\n\n\n")
//                             print(html!)
//                         })
//        }
//
//    }
    
    

    
}
