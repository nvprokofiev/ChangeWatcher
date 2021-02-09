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
    private var testItem: TestableWatchItem?
    
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
       testSelectors()
    }
    
    func cancel() {
        testItem = nil
        state = .running
    }
    
    func testSelectors() {
        
        guard let testItem = testItem else { return }
        state = .testing
        TestWatcherService.shared.test(testItem.watchItem) { result in
            
        }
    }
}

extension BrowserViewModel: WebViewStoreDelegate {
    
    func onLongTap(with message: Any) {
        
        guard let testItem =  try? TestableWatchItem(decodable: message) else { return }
        self.testItem = testItem
        let point = convertTapPointIntoGlobvalCoordinates(testItem.tapPoint)
        state = .longTapDetected(point: point)
    }
    
}
