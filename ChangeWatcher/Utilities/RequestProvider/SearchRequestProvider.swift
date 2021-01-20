//
//  SearchRequestProvider.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-01-18.
//

import Foundation
import PublicSuffix

class SearchRequestProvider {
    
    private var query: String
    private var searchEngine: SearchEngine
    
    init(for query: String, engine: SearchEngine) {
        self.query = query
        self.searchEngine = engine
    }

    func getURLRequest(with completion: @escaping (Result<URLRequest, SearchRequestError>)->()) {
        if let url = url {
            checkRechability(for: url) { success in
                if success {
                    let request = URLRequest(url: url)
                    completion(.success(request))
                } else {
                    completion(.failure(.urlNotReachable))
                }
            }
        } else {
            guard let request = searchEngine.buildSearchURLRequest(for: query) else {
                return completion(.failure(.buildRequestFailure))
            }
            completion(.success(request))
        }
    }

    private var url: URL? {

        guard let url = URL(string: query) else { return nil }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }
        guard let domainComponents = SuffixList.default.parse(query) else { return nil }
        
        if domainComponents.hasKnownTLD {
            if urlComponents.scheme == nil {
                urlComponents.scheme = "https"
            }
            return urlComponents.url
        }
        return nil
    }
    
    private func checkRechability(for url: URL, _ completion: @escaping (Bool)->()) {
        NetworkService().ping(url) { success in
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
}
