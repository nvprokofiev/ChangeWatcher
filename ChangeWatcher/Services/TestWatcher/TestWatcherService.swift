//
//  TestWatcherService.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-01-27.
//

import Foundation

class TestWatcherService {
    
    static var shared: TestWatcherService = TestWatcherService()
    
    private init() {}

    func test(_ item: WatchItem, completion: @escaping ((Swift.Result<Void, TestWatcherError>) -> Void )){
        guard let url = URL(string: item.urlString) else {
            completion(.failure(.invalidURLString))
            return
        }
        let params = SelectorTesterParameters(url: url, matchValue: item.value, selectors: item.selectors)
        
        var stringContentTester = StringContentSelectorTester(parameters: params)
        let erikSelectorTester = ErikSelectorTester(parameters: params)
        
        stringContentTester.setNext(erikSelectorTester)
        
        stringContentTester.test { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let selectors):
                self.handleSuccessTest(with: selectors)
            case .failure(let error):
                self.handleFailureTest(with: error)
            }
        }
    }
    
    private func handleSuccessTest(with selectors: [CSSSelector]) {
        print(selectors)
    }
    
    private func handleFailureTest(with error: TestWatcherError) {
        print(error)
    }
    
}
