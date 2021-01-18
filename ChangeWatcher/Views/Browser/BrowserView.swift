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
//                    BrowserSearchView(searchText: $webViewStore.query)
                    Button {
//                        webViewStore.query = "https://www.zara.com/ca/en/printed-sweatshirt-p06224597.html?v1=64726814&v2=1541286"
                        webViewStore.query = "https://en.m.wikipedia.org/wiki/Old_Navy"
                    } label: {
                        Text("Go")
                            .font(.title)
                    }
                    .background(Color.white)
                    .foregroundColor(.black)
                    .clipShape(Capsule())
                    .background(Capsule().strokeBorder(lineWidth: 1, antialiased: true))
                    .padding(.trailing, 16)
                }

                ZStack {
                    BrowserWebView(webView: webViewStore.webView )
                    
                    if estimatedProgress > 0 && estimatedProgress < 1 {
                        VStack {
                            ProgressView(value: estimatedProgress)
                                .progressViewStyle(LinearProgressViewStyle())
                                .animation(.easeIn)
                            Spacer()
                        }
                    }
                }
                
//                BrowserToolbarView(backButtonHandler: (webViewStore.webView.canGoBack, webViewStore.goBack),
//                                   forwardButtonHandler: (webViewStore.webView.canGoForward, webViewStore.goForward))
                
            }
            .ignoresSafeArea(.all, edges: .bottom)
            
//            if isLongTapDetected {
//                AddWatcherView(viewModel: AddWatcherViewModel(store: webViewStore))
//            }

        }.onAppear {
            webViewStore.loadQuery("")
        }

    }
}

struct BrowserView_Previews: PreviewProvider {
    static var previews: some View {
        BrowserView()
            .preferredColorScheme(.dark)
    }
}
