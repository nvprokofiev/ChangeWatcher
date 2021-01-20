//
//  SearchRequestError.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-01-19.
//

import Foundation

enum SearchRequestError: Error {
    case buildRequestFailure
    case urlNotReachable
}
