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
