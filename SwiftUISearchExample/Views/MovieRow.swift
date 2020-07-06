//
//  ItemListRow.swift
//  SwiftUISearchExample
//
//  Created by James Rochabrun on 7/5/20.
//

import SwiftUI

struct MovieRow: View {
    var body: some View {
        HStack {
            Image(uiImage: UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .background(Color.black)
                .cornerRadius(20)
                .padding(.trailing, 4)
            
            VStack(alignment: .leading, spacing: 8.0) {
                Text("title")
                    .font(.system(size: 20, weight: .bold))
                Text("subtitile")
                    .lineLimit(2)
                    .font(.subheadline)
                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                
                Text("s")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary) // adaptive to dark mode
            }
        }
        .padding(.vertical, 8)
    }
}

struct ItemListRow_Previews: PreviewProvider {
    static var previews: some View {
        MovieRow()
    }
}
