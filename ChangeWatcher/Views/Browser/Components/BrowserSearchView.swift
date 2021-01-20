//
//  BrowserSearchView.swift
//  UpdatesWatcher
//
//  Created by Nikolai Prokofev on 2020-09-20.
//

import SwiftUI

struct BrowserSearchView: View {
    @State private var innerText = String()
    @Binding var searchText: String

    private let constants = Constants()

    var body: some View {
        ZStack {
            TextField(constants.placeholder,
                      text: $innerText,
                      onCommit: {
                        searchText = innerText
                      }
            )
            .font(.subheadline)
            .frame(height: constants.height)
            .padding(.horizontal, 16)
            .background(RoundedRectangle(cornerRadius: constants.height / 2)
                            .strokeBorder(lineWidth: 1, antialiased: true)
                            .foregroundColor(Color(.secondaryLabel)))

        }
    }
}

struct BrowserSearchView_Previews: PreviewProvider {

    static var previews: some View {
        BrowserSearchView(searchText: .constant("https://www.google.com"))
    }
}

extension BrowserSearchView {
    
    private struct Constants {
        let height: CGFloat = 36
        let placeholder = "Search or typer URL"
    }
}
