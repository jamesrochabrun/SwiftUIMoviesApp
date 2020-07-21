//
//  ImageViewLoader.swift
//  SwiftUISearchExample
//
//  Created by James Rochabrun on 7/21/20.
//

import SwiftUI

struct LoaderImageView: View {
    
    @ObservedObject var imageLoader: URLImageLoader
    
    private let errorImage: UIImage?

    init(urls: (urlString: String?, lowResURLString: String?), errorImage: UIImage?) {
        imageLoader = URLImageLoader(urls: urls, errorImage: errorImage)
        self.errorImage = errorImage
    }
    
    var body: some View {
        Image(uiImage: imageLoader.image ?? self.errorImage!)
            .resizable()
           // .scaledToFit()
            .scaledToFill()
            .frame(width: 100, height: 100)
    }
}
