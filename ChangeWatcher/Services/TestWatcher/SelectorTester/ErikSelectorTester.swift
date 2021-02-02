//
//  ErikSelectorTester.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-02-01.
//

import Foundation

struct ErikSelectorTester: SelectorTester {
    
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
        Erik.visit(url: url) { result in
            switch result {
            case .failure(let error):
                return completion(.failure(error))
            case .success(let html):
                completion(.success(html))
            }
        }
    }
}
