//
//  YandexSearchEngine.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-01-19.
//

import Foundation

struct YandexSearchEngine: SearchEngine {
    
    var host = "yandex.com"
    var path = "/search"

    func configureURLComponents(for query: String) -> URLComponents {
        let queryItem = URLQueryItem(name: "text", value: query)
        var components = defaultComponents
        components.queryItems?.append(queryItem)
        return components
    }
}
