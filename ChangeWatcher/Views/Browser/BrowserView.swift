//
//  BrowserView.swift
//  UpdatesWatcher
//
//  Created by Nikolai Prokofev on 2020-09-20.
//

import SwiftUI

struct BrowserView: View {
    
    @ObservedObject private var viewModel = BrowserViewModel()

    var body: some View {

        ZStack {
            VStack(spacing: 2) {
                HStack(spacing: 0) {
                    BrowserSearchView(searchText: $viewModel.query)
                        .padding(.horizontal, 10)
                }
                ZStack {
                    BrowserWebView(webView: viewModel.webView )
                    progressView
                }
                toolbarView
            }
            .ignoresSafeArea(.all, edges: .bottom)
            
            if case let BrowserState.longTapDetected(point: point) = viewModel.state {
                AddWatcherView(viewModel: viewModel, at: point)
            }
        }
    }
    
    private var progressView: some View {
        let progress = viewModel.estimatedProgress
        if progress > 0 && progress < 1 {
            return AnyView( VStack {
                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle())
                    .animation(.easeIn)
                Spacer()
                
            }
            )
        }
        return AnyView(EmptyView())
    }
    
    private var toolbarView: some View {
        AnyView(BrowserToolbarView(backButton: (viewModel.canGoBack, viewModel.goBack),
                                   forwardButton: (viewModel.canGoForward, viewModel.goForward)))
    }
}

struct BrowserView_Previews: PreviewProvider {
    static var previews: some View {
        BrowserView()
    }
}
