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
            
            if viewModel.state == .testing {
                VStack(spacing: 20) {
                    Text("Testing")
                        .font(Font.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                    ActivityIndicatorView(isAnimating: .constant(true))
                }
                .frame(width: 180, height: 180)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(radius: 20)
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
