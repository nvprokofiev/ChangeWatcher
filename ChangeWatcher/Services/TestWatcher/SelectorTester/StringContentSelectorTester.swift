//
//  StringContentSelectorTester.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-02-01.
//

import Foundation

struct StringContentSelectorTester: SelectorTester {
    
    var parameters: SelectorTesterParameters
    
    func test(_ completion: @escaping (Result<[CSSSelector], Error>)-> Void) {
        getHTML(from: parameters.url) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let html):
                SwiftSoupHTMLInspector.shared.inspect(html, for: parameters.selectors, matching: parameters.matchValue, completion)
            }
        }
    }

    private func getHTML(from url: URL, _ completion: @escaping (Result<String, Error>) -> Void) {
        guard let html = try? String(contentsOf: url) else {
            return completion(.failure(TestWatcherError.failedHTMLGrabbing))
        }
        completion(.success(html))
    }
}
