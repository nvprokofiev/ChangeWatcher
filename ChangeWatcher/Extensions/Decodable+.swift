//
//  Decodable+.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-01-28.
//

import Foundation

extension Decodable {
    
    init(decodable: Any) throws {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: decodable, options: .prettyPrinted)
            let decoded = try JSONDecoder().decode(Self.self, from: jsonData)
            self = decoded
        } catch (let error) {
            throw(error)
        }
    }
}
