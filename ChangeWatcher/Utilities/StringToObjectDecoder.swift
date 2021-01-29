//
//  WatchableService.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-01-27.
//

import Foundation

struct StringToObjectDecoder {

    static func parse<T:Decodable>(to type: T.Type, from string: String) throws -> T {

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: string, options: .prettyPrinted)
            let watchItem = try JSONDecoder().decode(type, from: jsonData)
            return watchItem
        } catch (let error) {
            throw(error)
        }
    }
}
