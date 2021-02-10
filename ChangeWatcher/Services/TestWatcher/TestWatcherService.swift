//
//  TestWatcherService.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-01-27.
//

import Foundation

enum TestMethod: Int {
    
    case stringContent
    case headlessBrowser
    case headlessBrowserWithDelay
}

class TestWatcherService {
    
    static var shared: TestWatcherService = TestWatcherService()
    
    private init() {}

    func test(_ item: JSItem, completion: @escaping (TestSelectorsResult) -> Void){
        guard let url = URL(string: item.urlString) else {
            completion(.failure(.invalidURLString))
            return
        }
        let params = SelectorTesterParameters(url: url, matchValue: item.value, selectors: item.selectors)
        
        var stringContentTester = StringContentSelectorTester(parameters: params)
        let erikSelectorTester = ErikSelectorTester(parameters: params)
        stringContentTester.setNext(erikSelectorTester)
        
        stringContentTester.test { completion($0) }
    }
}
