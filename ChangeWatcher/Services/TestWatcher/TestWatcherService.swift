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
    
    func test(item: WatchItem, using tester: SelectorTester, completion: @escaping ((Swift.Result<Void, TestWatcherError>) -> Void )){
        
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
    
//    func test(item: WatchItem,
//              with grabber: WebGrabber,
//              completion: @escaping ((Swift.Result<Void, TestWatcherError>) -> Void )){
//

//
//        switch grabber {
//        case .stringContent:
//            asString(from: url, for: item, completion: completion)
//        default:
//            print("hello")
//
//        }
//    }
    
    
    /*
    
    private func asString(from url: URL,
                          for item: WatchingItem,
                          completion: @escaping ((Swift.Result<Void, WatcherError>) -> Void )){
        
        guard let html = try? String(contentsOf: url) else {
            completion(.failure(.failedHTMLGrabbing))
            return
        }
        guard let body = try? SwiftSoup.parse(html).body() else {
            completion(.failure(.failedHTMLParsing))
            return
        }
        
        do {
            let elements = try body.select(item.selector)
            
            guard elements.count <= 1 else {
                completion(.failure(.multipleValuesFound))
                return
            }
            
            guard let element = elements.first() else {
                completion(.failure(.valueNotFound))
                return
            }
            guard let value = try? element.text() else {
                completion(.failure(.unableToGetOuterHTML))
                return
            }
            
            guard value == item.value else {
                completion(.failure(.mismatchedValue(value: item.value, newValue: value)))
                return
            }
            completion(.success)
            
        } catch (let error) {
            print("☹️ selector", error)
            completion(.failure(.failedHTMLScrapig))
        }
    }
     */
}



