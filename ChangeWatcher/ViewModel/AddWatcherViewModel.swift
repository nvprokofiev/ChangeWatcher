//
//  AddWatcherViewModel.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-01-27.
//

import Foundation

class AddWatcherViewModel: ObservableObject {

    private let watchItem: WatchItem
    
     init(_ watchItem: WatchItem) {

        self.watchItem = watchItem
    }
    
    func testWatchItem() {
        
    }
}
