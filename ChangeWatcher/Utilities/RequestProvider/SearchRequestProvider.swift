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
    private var domainComponents: DomainComponents?
    
    init(for query: String) {
        self.query = query
        self.domainComponents = SuffixList.default.parse(query)
        self.searchEngine = .google(query)
    }

    var request: URLRequest? {
        if let url = url {
            return RequestType.url(url).request
        } else {
            return RequestType.search(using: searchEngine).request
        }
    }
    
    #warning("Check how url deals wth queries like https://www.google.com") //doesn't holds
    
    private var url: URL? {

        if query.isValidURL() {
            #warning("thinks that https://www.google is valid url")
            return URL(string: query)
        }
        
        guard let components = domainComponents else { return nil }

        if components.hasKnownTLD {
            
        }
            
            
            
            
//            if let domainName = domainName {
//                let prefix = "https://" + (domainName.subdomain ?? "www") + "."
//                let urlString = prefix + domainName.domain
//                return URL(string: urlString)
//            }
        return nil
    }
}

