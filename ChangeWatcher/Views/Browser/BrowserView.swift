//
//  BrowserView.swift
//  UpdatesWatcher
//
//  Created by Nikolai Prokofev on 2020-09-20.
//

import SwiftUI

enum BrowserState {
    case initial
    case running // when set to running - remove all highlights
    case pageNotRechable
    case longTapDetected(watchItem: TestableWatchItem)
}

struct BrowserView: View {
    
    @State var query = String()
    @StateObject var webViewStore = WebViewStore()
    
    var browserState: BrowserState {
        webViewStore.browserState
    }
    
    private var estimatedProgress: Double {
        webViewStore.webView.estimatedProgress
    }
    
    var body: some View {

        ZStack {
            VStack(spacing: 2) {
                HStack(spacing: 0) {
                    BrowserSearchView(searchText: $webViewStore.query)
                        .padding(.horizontal, 10)
                }
                ZStack {

                    BrowserWebView(webView: webViewStore.webView )
                    progressView
                }
                toolbarView
            }
            .ignoresSafeArea(.all, edges: .bottom)
            
            if case let BrowserState.longTapDetected(watchItem: item) = browserState {
                AddWatcherView(viewModel: AddWatcherViewModel(item, in: webViewStore.webView), state: $webViewStore.browserState)
            }
        }
    }
    
    private var progressView: some View {
        if estimatedProgress > 0 && estimatedProgress < 1 {
            return AnyView( VStack {
                ProgressView(value: estimatedProgress)
                    .progressViewStyle(LinearProgressViewStyle())
                    .animation(.easeIn)
                Spacer()
                
            }
            )
        }
        return AnyView(EmptyView())
    }
    
    private var toolbarView: some View {
        AnyView(BrowserToolbarView(backButtonHandler: (webViewStore.webView.canGoBack, webViewStore.goBack),
                           forwardButtonHandler: (webViewStore.webView.canGoForward, webViewStore.goForward)))
    }
}

struct BrowserView_Previews: PreviewProvider {
    static var previews: some View {
        BrowserView()
    }
}
