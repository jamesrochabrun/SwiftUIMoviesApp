//
//  FilteredList.swift
//  SwiftUISearchExample
//
//  Created by James Rochabrun on 7/2/20.
//

import SwiftUI

public struct FilteredList<Element, FilterKey, RowContent>: View
        where Element: Identifiable, RowContent: View {

    private let data: [Element]
    private let filterKey: KeyPath<Element, FilterKey>
    private let isIncluded: (FilterKey) -> Bool
    private let rowContent: (Element) -> RowContent

    public init(
        _ data: [Element],
        filterBy key: KeyPath<Element, FilterKey>,
        isIncluded: @escaping (FilterKey) -> Bool,
        @ViewBuilder rowContent: @escaping (Element) -> RowContent
    ) {
        self.data = data
        self.filterKey = key
        self.isIncluded = isIncluded
        self.rowContent = rowContent
    }

    public var body: some View {
        let filteredData = data.filter {
            isIncluded($0[keyPath: filterKey])
        }
        return List(filteredData, rowContent: rowContent)
    }
}


struct ItemsList<Element: Searchable, RowContent: View>: View {
    
    private let rowContent: (Element) -> RowContent
    private let items: [Element]
    
    @State var searchPhrase = ""
    
    public init(
        _ items: [Element],
        @ViewBuilder rowContent: @escaping (Element) -> RowContent
    ) {
        self.items = items
        self.rowContent = rowContent
    }
    
    var body: some View {
        VStack {
            TextField("Search", text: $searchPhrase)
                .frame(height: 60)
                .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                .padding(.leading, 10)
                .padding(.trailing, 10)
            FilteredList(items,
                         filterBy: \.query,
                         isIncluded:  { query in
                            return query.hasSubstring(searchPhrase.lowercased()) },
                         rowContent: rowContent)
        }
    }
}

protocol Searchable: Identifiable {
    var query: String { get }
}


extension String {
    /// Returns `true` if this string contains the provided substring,
    /// or if the substring is empty. Otherwise, returns `false`.
    ///
    /// - Parameter substring: The substring to search for within
    ///   this string.
    func hasSubstring(_ substring: String) -> Bool {
        substring.isEmpty || contains(substring)
    }
}
