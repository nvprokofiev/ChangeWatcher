//
//  BrowserInitialView.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-01-27.
//

import Foundation
import SwiftUI

struct BrowserInitialView: View {
    
    @Binding var searchText: String

    var body: some View {
        BrowserSearchView(searchText: $searchText)
            .padding(.horizontal, 10)
    }
}
