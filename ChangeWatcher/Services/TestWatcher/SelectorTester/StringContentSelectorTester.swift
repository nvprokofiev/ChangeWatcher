//
//  StringContentSelectorTester.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-02-01.
//

import Foundation

struct StringContentSelectorTester: SelectorTester {

    var parameters: SelectorTesterParameters
    var nextTester: SelectorTester?

    func getHTML( _ completion: @escaping (Result<String, TestWatcherError>) -> Void) {
        guard let html = try? String(contentsOf: parameters.url) else {
            return completion(.failure(TestWatcherError.failedHTMLGrabbing))
        }
        completion(.success(html))
    }
}
