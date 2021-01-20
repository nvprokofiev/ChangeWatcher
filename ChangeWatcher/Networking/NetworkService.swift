//
//  NetworkService.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-01-19.
//

import Foundation

class NetworkService {
    
    func ping(_ url: URL, _ completion: @escaping (Bool)->()) {
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"

        URLSession(configuration: .default)
          .dataTask(with: request) { (_, response, error) -> Void in
            guard error == nil else {
                return completion(false)
            }
            guard (response as? HTTPURLResponse)?
              .statusCode == 200 else {
                return completion(false)
            }
            completion(true)
          }
          .resume()
    }
}
