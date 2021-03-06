//
//  ModelFlickrPhoto.swift
//  Flickr Image Gallery
//
//  Created by Enrique Melgarejo on 15/10/17.
//  Copyright © 2017 Choynowski. All rights reserved.
//

import Foundation

struct ModelFlickrPhoto {

    var title: String?
    var link: URL?
    var media: URL?
    var dateTaken: Date?
    var _description: String?
    var published: Date?
    var author: String?
    var authorId: String?
    var tags: String?

    enum CodingKeys: String, CodingKey {
        case title
        case link
        case media
        case dateTaken = "date_taken"
        case _description = "description"
        case published
        case author
        case authorId = "author_id"
        case tags
    }

    enum MediaKeys: String, CodingKey {
        case media = "m"
    }
}

extension ModelFlickrPhoto: Encodable {
    func encode(to encoder: Encoder) throws {
        var photo = encoder.container(keyedBy: CodingKeys.self)
        try photo.encodeIfPresent(title, forKey: .title)
        try photo.encodeIfPresent(link, forKey: .link)
        try photo.encodeIfPresent(dateTaken, forKey: .dateTaken)
        try photo.encodeIfPresent(_description, forKey: ._description)
        try photo.encodeIfPresent(published, forKey: .published)
        try photo.encodeIfPresent(author, forKey: .author)
        try photo.encodeIfPresent(authorId, forKey: .authorId)
        try photo.encodeIfPresent(tags, forKey: .tags)

        var mediaContainer = photo.nestedContainer(keyedBy: MediaKeys.self, forKey: .media)
        try mediaContainer.encodeIfPresent(media, forKey: .media)
    }
}

extension ModelFlickrPhoto: Decodable {

    init(from decoder: Decoder) throws {
        let photo = try decoder.container(keyedBy: CodingKeys.self)
        title = try photo.decodeIfPresent(String.self, forKey: .title)
        link = try photo.decodeIfPresent(URL.self, forKey: .link)
        dateTaken = try photo.decodeIfPresent(Date.self, forKey: .dateTaken)
        _description = try photo.decodeIfPresent(String.self, forKey: ._description)
        published = try photo.decodeIfPresent(Date.self, forKey: .published)
        author = try photo.decodeIfPresent(String.self, forKey: .author)
        authorId = try photo.decodeIfPresent(String.self, forKey: .authorId)
        tags = try photo.decodeIfPresent(String.self, forKey: .tags)

        let mediaValues = try photo.nestedContainer(keyedBy: MediaKeys.self, forKey: .media)
        media = try mediaValues.decodeIfPresent(URL.self, forKey: .media)
    }
}

