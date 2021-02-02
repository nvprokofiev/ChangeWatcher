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
        let tester = ErikSelectorTester(parameters: params)

        tester.test { result in
            switch result {
                case .success(let selectors):
                        print(selectors)
                case .failure(let error):
                    print(error)
            }
        }
    }
}



