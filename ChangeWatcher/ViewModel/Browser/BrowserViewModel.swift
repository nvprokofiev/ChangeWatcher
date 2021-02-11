//
//  BrowserViewModel.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-02-09.
//

import Foundation
import WebKit
import Combine
import SwiftUI

class BrowserViewModel: ObservableObject {
    
    @Published var state: BrowserState = .initial
    @Published var query: String = "" {
        didSet { loadQuery(query) }
    }
    
    @ObservedObject private var webViewStore = WebViewStore()
    
    private var anyCancellable: AnyCancellable? = nil
    private var searchEngine = GoogleSearchEngine()
    private var jsItem: JSItem?
    
    init() {
        webViewStore.delegate = self
        setObserver()
    }
    
    //MARK: - Properties
    
    var webView: WKWebView { webViewStore.webView }
    var canGoBack: Bool { webViewStore.webView.canGoBack }
    var canGoForward: Bool { webViewStore.webView.canGoForward }
    var estimatedProgress: Double { webViewStore.webView.estimatedProgress }
    
    private func setObserver() {
        anyCancellable = webViewStore.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }
    }

    //MARK: - Methods
    
    func goBack() {
        webView.goBack()
    }
    
    func goForward() {
        webView.goForward()
    }
    
    //MARK: - Engine
    
    private func loadQuery(_ query: String) {
        let provider = SearchRequestProvider(for: query, engine: searchEngine)
        
        provider.getURLRequest { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                self.state = .pageNotRechable
            case .success(let request):
                self.state = .running
                self.webViewStore.webView.load(request)
            }
        }
    }
    
    private func convertTapPointIntoGlobvalCoordinates(_ point: WebViewTapPoint) -> CGPoint {
        var globalPoint = webViewStore.webView.convert(point.point, to: UIScreen.main.coordinateSpace)
        globalPoint.y -= 70
        return globalPoint
    }
    
    func add() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.testSelectors { result in
                switch result {
                case .success(let testResult):
                    let watchItem = self.buildWatchItem(with: testResult)
                    print("✅", watchItem)
                    self.state = .running
                case .failure(let error):
                    self.state = .running
                    print(error)
                }
            }
        }

    }
    
    func cancel() {
        jsItem = nil
        state = .running
    }
    
    private func buildWatchItem(with testResult: (method: TestMethod, selectors: [CSSSelector]))-> WatchItem? {
        guard let jsItem = jsItem else { return nil }
        let item = WatchItem(urlString: jsItem.urlString, value: jsItem.value, selectors: testResult.selectors, testMethod: testResult.method)
        return item
    }
    
    private func testSelectors(_ completion: @escaping (TestSelectorsResult)->()) {
        guard let item = jsItem else { return }
        state = .testing
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: {
            TestWatcherService.shared.test(item) { completion($0) }
        })
    }
}

extension BrowserViewModel: WebViewStoreDelegate {
    
    func onLongTap(with message: Any) {
        
        guard let jsItem =  try? JSItem(decodable: message) else { return }
        jsItem.selectors.forEach{ print($0, "\n")}
        self.jsItem = jsItem
        let point = convertTapPointIntoGlobvalCoordinates(jsItem.tapPoint)
        state = .longTapDetected(point: point)
    }
}
