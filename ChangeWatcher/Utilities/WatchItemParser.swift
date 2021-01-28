//
//  WatchableService.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-01-27.
//

import Foundation

typealias JSMessageBody = Any

struct WatchItemParser {

    static func parse(from string: JSMessageBody) throws -> WatchItem {

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: string, options: .prettyPrinted)
            let watchItem = try JSONDecoder().decode(WatchItem.self, from: jsonData)
            return watchItem
        } catch (let error) {
            throw(error)
        }
    }
}
