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

    func test(_ item: JSItem, completion: @escaping (TestSelectorsResult) -> Void){
        guard let url = URL(string: item.urlString) else {
            completion(.failure(.invalidURLString))
            return
        }
        let params = SelectorTesterParameters(url: url, matchValue: item.value, selectors: item.selectors)
        
        var stringContentTester = StringContentSelectorTester(parameters: params)
        var erikSelectorTester = ErikSelectorTester(parameters: params, delay: 1.5)
//        var delayedTester = ErikSelectorTester(parameters: params, delay: 6.0)

//        delayedTester.setNext(erikSelectorTester)
        stringContentTester.setNext(erikSelectorTester)

        stringContentTester.test { completion($0) }
    }
}
