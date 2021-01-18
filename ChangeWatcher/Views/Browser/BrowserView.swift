//
//  BrowserView.swift
//  UpdatesWatcher
//
//  Created by Nikolai Prokofev on 2020-09-20.
//

import SwiftUI

struct BrowserView: View {
    
    @State var query = String()
    @StateObject var webViewStore = WebViewStore()
    
    var isLongTapDetected: Bool {
        false
//        webViewStore.longTapDetected
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
                BrowserToolbarView(backButtonHandler: (webViewStore.webView.canGoBack, webViewStore.goBack),
                                   forwardButtonHandler: (webViewStore.webView.canGoForward, webViewStore.goForward))
                
            }
            .ignoresSafeArea(.all, edges: .bottom)
            
//            if isLongTapDetected {
//                AddWatcherView(viewModel: AddWatcherViewModel(store: webViewStore))
//            }
            
        }.onAppear {
            webViewStore.loadQuery("")
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
}

struct BrowserView_Previews: PreviewProvider {
    static var previews: some View {
        BrowserView()
    }
}
