//
//  KannaHTMLInspector.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-02-10.
//

import Foundation
import Kanna


class KannaHTMLInspector: HTMLInspector {
    
    static let shared: KannaHTMLInspector = KannaHTMLInspector()
    
    private init() {}
    
    func inspect(_ html: HTML, for selectors: [CSSSelector], matching value: String, _ completion: @escaping (Result<[CSSSelector], TestWatcherError>) -> Void) {
        
        guard let doc = try? Kanna.HTML(html: html, encoding: .utf8) else {
            return completion(.failure(TestWatcherError.failedHTMLScrapig))
        }
        
        guard let body = doc.body else {
            return completion(.failure(TestWatcherError.failedHTMLParsing))
        }
        
        var succedSelectors = [CSSSelector]()

        selectors.forEach { selector in
                        
            let elements = body.css(selector)
            
            guard elements.count <= 1 else {
                return print("❌",  selector, TestWatcherError.multipleValuesFound, "\n")
            }
            
            guard let element = elements.first else {
                return print("❌", selector, TestWatcherError.valueNotFound, "\n")
            }
            
            guard let testValue = element.text else {
                return print("❌", selector, TestWatcherError.unableToGetOuterHTML, "\n")
            }
            
            guard testValue.lowercased() == value.lowercased() else {
                return print("❌", selector, TestWatcherError.mismatchedValue(value: value, newValue: testValue), "\n")
            }
            
            succedSelectors.append(selector)
        }
        
        guard !succedSelectors.isEmpty else {
            print("❌ TEST FAILED ❌")
            completion(.failure(.testFailed))
            return
        }
        
        completion(.success(succedSelectors))
    }
}
