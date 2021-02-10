//
//  SelectorTester.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-02-01.
//

import Foundation

typealias CSSSelector = String
typealias TestSelectorsResult = Result<(TestMethod, [CSSSelector]), TestWatcherError>

protocol SelectorTester {
    
    mutating func setNext(_ tester: SelectorTester)
    var nextTester: SelectorTester? { get set }
    var parameters: SelectorTesterParameters { get }
    var testMethod: TestMethod { get }
    func test(_ completion: @escaping (TestSelectorsResult) -> Void)
    func getHTML(_ completion: @escaping (Result<String, TestWatcherError>) -> Void)
}

extension SelectorTester {
    
    mutating func setNext(_ tester: SelectorTester) {
        nextTester = tester
    }
    
    func test(_ completion: @escaping (TestSelectorsResult) -> Void) {

        getHTML { result in
            switch result {
            case .failure(let error):
                if let nextTester = nextTester {
                    nextTester.test(completion)
                } else {
                    completion(.failure(error))
                }
            case .success(let html):
                SwiftSoupHTMLInspector.shared.inspect(html, for: parameters.selectors, matching: parameters.matchValue) { result in
                    switch result {
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(let selectors):
                        completion(.success((testMethod, selectors)))
                    }
                    
                }
            }
        }
    }
}
