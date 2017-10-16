//
//  FeedViewModel.swift
//  Flickr Image Gallery
//
//  Created by Enrique Melgarejo on 14/10/17.
//  Copyright © 2017 Choynowski. All rights reserved.
//

import Foundation

class FeedViewModel: NSObject {

    private let flickrService: FlickrService

    init(flickrService: FlickrService = FlickrService()) {
        self.flickrService = flickrService
    }
}
