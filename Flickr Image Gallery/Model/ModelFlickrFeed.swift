//
//  ModelFlickrFeed.swift
//  Flickr Image Gallery
//
//  Created by Enrique Melgarejo on 15/10/17.
//  Copyright © 2017 Choynowski. All rights reserved.
//

import Foundation

struct ModelFlickrFeed: Codable {

    var title: String?
    var link: URL?
    var modified: Date?
    var generator: URL?
    var items: [ModelFlickrPhoto]?
}

