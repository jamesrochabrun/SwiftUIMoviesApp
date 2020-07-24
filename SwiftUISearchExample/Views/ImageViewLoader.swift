//
//  ImageViewLoader.swift
//  SwiftUISearchExample
//
//  Created by James Rochabrun on 7/21/20.
//

import SwiftUI

struct ImageViewCache: View {
    
    // MARK:- Subscribers
    @ObservedObject var imageLoader: ImageLoader
    
    private let errorImage: UIImage?
    
    init(urls: (urlString: String?, lowResURLString: String?), errorImage: UIImage?) {
        imageLoader = ImageLoader(urls: urls, errorImage: errorImage)
        self.errorImage = errorImage
    }
    
    var body: some View {
        Image(uiImage: imageLoader.image ?? self.errorImage!)
            .resizable()
    }
}
