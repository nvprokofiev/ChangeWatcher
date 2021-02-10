//
//  ErikSelectorTester.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-02-01.
//

import Foundation

struct ErikSelectorTester: SelectorTester {
    
    let testMethod = TestMethod.headlessBrowser
    var parameters: SelectorTesterParameters
    var nextTester: SelectorTester?
    
    func getHTML(_ completion: @escaping (Result<String, TestWatcherError>) -> Void) {
        Erik.visit(url: parameters.url) { result in
            switch result {
            case .failure(let error):
                return completion(.failure(.other(error)))
            case .success(let html):
                completion(.success(html))
            }
        }
    }
}
