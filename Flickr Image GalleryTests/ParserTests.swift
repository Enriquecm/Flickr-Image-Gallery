//
//  ParserTests.swift
//  Flickr Image GalleryTests
//
//  Created by Enrique Melgarejo on 16/10/17.
//  Copyright © 2017 Choynowski. All rights reserved.
//

import XCTest
@testable import Flickr_Image_Gallery

class ParserTests: XCTestCase {

    private var modelFeedMock: ModelFlickrFeed!
    private var dataFeedMock: Data!
    private let date = Date(timeIntervalSince1970: 1000000)
    
    override func setUp() {
        super.setUp()
        let modelPhotoMock = ModelFlickrPhoto(title: "Photo", link: URL(string: "www.google.com"), media: nil, dateTaken: date, _description: "Description", published: date, author: "author", authorId: "author id", tags: "no tags")

        modelFeedMock = ModelFlickrFeed(title: "Title", link: URL(string: "www.google.com"), modified: date, generator: URL(string: "www.facebook.com"), items: [modelPhotoMock])
        let encoder = JSONEncoder()
        if #available(iOS 10.0, *) {
            encoder.dateEncodingStrategy = .iso8601
        } else {
            encoder.dataEncodingStrategy = .base64
        }

        dataFeedMock = try! encoder.encode(modelFeedMock)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParserMethods() {
        let feedParser = Parser<ModelFlickrFeed>()
        XCTAssertNotNil(feedParser, "The parser should not be nil.")

        let feed = try? feedParser.parse(from: dataFeedMock, with: feedParser.dateDecodingStrategy())
        XCTAssertNotNil(feed, "The feed should not be nil.")
        XCTAssertEqual(feed?.title, "Title", "The title should be the same.")
        XCTAssertEqual(feed?.items?.count, 1, "The items should be empty.")
    }
}
