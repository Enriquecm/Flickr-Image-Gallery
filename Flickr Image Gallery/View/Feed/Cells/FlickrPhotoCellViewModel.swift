//
//  FlickrPhotoCellViewModel.swift
//  Flickr Image Gallery
//
//  Created by Enrique Melgarejo on 16/10/17.
//  Copyright © 2017 Choynowski. All rights reserved.
//

import Foundation

final class FlickrPhotoCellViewModel: NSObject {

    let author: String?

    let media: URL?

    init(photo: ModelFlickrPhoto) {
        author = photo.author?.formatFlickrAuthor()
        media = photo.media
    }
}

private extension String {

    func formatFlickrAuthor() -> String? {
        let author = self.slice(from: "(\"", to: "\")")
        return author
    }
}
