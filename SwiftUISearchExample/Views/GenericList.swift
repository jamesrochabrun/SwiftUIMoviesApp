//
//  GenericList.swift
//  SwiftUISearchExample
//
//  Created by James Rochabrun on 7/22/20.
//

import SwiftUI

// 1
struct GenericList<Element,  RowContent: View>: View where Element: Identifiable {
    
    // 2
    private let items: [Element]
    private let rowContent: (Element) -> RowContent

    // 3
    public init(_ items: [Element], @ViewBuilder rowContent: @escaping (Element) -> RowContent) {
        self.items = items
        self.rowContent = rowContent
    }
    
    // 4
    var body: some View {
        List(items, rowContent: rowContent)
    }
}
