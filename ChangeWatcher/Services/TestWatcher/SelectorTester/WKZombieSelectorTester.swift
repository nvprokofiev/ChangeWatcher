//
//  WKZombieSelectorTester.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-02-11.
//

import Foundation
import WKZombie

class WKZombieSelectorTester: SelectorTester {

    var nextTester: SelectorTester?
    var parameters: SelectorTesterParameters
    var testMethod: TestMethod = .wkZombie
    private let delay: Double
    private let browser = WKZombie.sharedInstance
    
    init(parameters: SelectorTesterParameters, nextTester: SelectorTester? = nil, delay: Double = 0.0) {
        self.parameters = parameters
        self.nextTester = nextTester
        self.delay = delay
    }

    func getHTML(_ completion: @escaping (Swift.Result<String, TestWatcherError>) -> Void) {
        
        let action: Action<HTMLPage> = self.browser.open(then: .wait(delay))(parameters.url)
        #warning("cancel current request")
        action.start { result in
            switch result {
            case .error(let error): completion(.failure(.other(error)))
            case .success(let html): completion(.success(html.description))
            }
        }
    }
}

extension ActionError: Error {}
