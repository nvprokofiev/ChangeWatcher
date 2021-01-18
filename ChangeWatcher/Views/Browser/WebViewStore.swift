//
//  WebViewStore.swift
//  UpdatesWatcher
//
//  Created by Nikolai Prokofev on 2020-09-28.
//

import SwiftUI
import WebKit
import Combine


class WebViewStore: NSObject, ObservableObject {
    
    @Published var webView: WKWebView {
        didSet { setupObservers() }
    }
    
    @Published var query: String = "" {
        didSet { loadQuery(query) }
    }
    
    @Published var longTapDetected: Bool = false
    
//    var watchingItem: WatchingItem?
    
    private var observers: [NSKeyValueObservation] = []
    
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
        
//        WKUserScript.CustomScripts.allCases.forEach {
//            configuration.add(script: $0, scriptMessageHandler: self)
//        }
        webView = WKWebView(frame: .zero, configuration: configuration)
        webView.allowsLinkPreview = false
        webView.navigationDelegate = self
//        webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 13_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 [FBAN/FBIOS;FBDV/iPhone12,1;FBMD/iPhone;FBSN/iOS;FBSV/13.3.1;FBSS/2;FBID/phone;FBLC/en_US;FBOP/5;FBCR/]"
    }
    
    
    func loadQuery(_ query: String) {
//        let provider = SearchRequestProvider(for: query)
//
//        guard let request = provider.request else { return }
        let request = URLRequest(url: URL(string: "https://en.m.wikipedia.org/wiki/Old_Navy")!)
        webView.load(request)
    }
    
    func goBack() {
        webView.goBack()
    }
    
    func goForward() {
        webView.goForward()
    }
    
//    func removeWatcher() {
//        watchingItem = nil
//        longTapDetected.toggle()
//        guard let script = JSStringProvider.removeAllHighlights.script else { return }
//        webView.evaluateJavaScript(script)
//    }
    
    var currentURL: URL?
    var isReloaded = false

}

extension WebViewStore: WKScriptMessageHandler  {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
//        longTapDetected.toggle()
//        guard let script = WKUserScript.CustomScripts.init(rawValue: message.name) else {
//            print("LONG TAP DETECTED - \(message.name)")
//            return
//        }
//        guard script == .longPressEvent else { return }
//        guard let watchingItem = WathingItemParser.parse(from: message.body) else { return }
//
//        self.watchingItem = watchingItem
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
