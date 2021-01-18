//
//  RequestType.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-01-18.
//

import Foundation

enum RequestType {
    
    case url(URL)
    case search(using: SearchEngine)
    
    var request: URLRequest? {
        switch self {
        case .url(let url):
            return URLRequest(url: url)
        case .search(using: let engine):
            guard let url = engine.construcSearchtURL() else { return nil }
            return URLRequest(url: url)
        }
    }
}
