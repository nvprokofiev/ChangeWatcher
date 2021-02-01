//
//  TestWatcherService.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-01-27.
//

import Foundation

class TestWatcherService {
    
    static var shared: TestWatcherService = TestWatcherService()
    let tester = ErikSelectorTester()
    
    private init() {}
    
    func test(_ item: WatchItem, completion: @escaping ((Swift.Result<Void, TestWatcherError>) -> Void )){
        
        guard let url = URL(string: item.urlString) else {
            completion(.failure(.invalidURLString))
            return
        }
        
        let selectors = item.selectors

        guard !selectors.isEmpty else {
            return print("No Selectors")
        }
        
        let value = item.value

        tester.test(selectors: selectors, from: url, matching: value) { result in
            switch result {
                case .success(let selectors):
                        print(selectors)
                case .failure(let error):
                    print(error)
            }
        }
        
    }
}



