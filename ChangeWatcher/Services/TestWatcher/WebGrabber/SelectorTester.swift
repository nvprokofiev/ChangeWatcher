//
//  WebGrabber.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-02-01.
//

import Foundation

typealias CSSSelector = String

protocol SelectorTester {
    
    func test(selectors: [CSSSelector], from url: URL, matching value: String, completion: @escaping (Result<[CSSSelector], TestWatcherError>)->Void)
}

//enum WebGrabber: Int {
//
//    case stringContent
//    case erik
//    case webView
//    case silentBrowser
//    case WKZombie
//}
//
//
//private func asString(from url: URL,
//                      for item: WatchingItem,
//                      completion: @escaping ((Swift.Result<Void, WatcherError>) -> Void )){
