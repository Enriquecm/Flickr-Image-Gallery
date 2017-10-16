//
//  ModelTests.swift
//  Flickr Image GalleryTests
//
//  Created by Enrique Melgarejo on 16/10/17.
//  Copyright © 2017 Choynowski. All rights reserved.
//

import XCTest
@testable import Flickr_Image_Gallery

class ModelTests: XCTestCase {

    private var modelFeedMock: ModelFlickrFeed!
    private var modelPhotoMock: ModelFlickrPhoto!

    private let date = Date(timeIntervalSince1970: 1000000)
    override func setUp() {
        super.setUp()
        modelPhotoMock = ModelFlickrPhoto(title: "Photo", link: URL(string: "www.google.com"), media: nil, dateTaken: date, _description: "Description", published: date, author: "author", authorId: "author id", tags: "no tags")

        modelFeedMock = ModelFlickrFeed(title: "Title", link: URL(string: "www.google.com"), modified: date, generator: URL(string: "www.facebook.com"), items: [modelPhotoMock])
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testModelFlickrPhoto() {
        XCTAssertEqual(modelPhotoMock.title, "Photo", "The title should be the same from init method")
        XCTAssertEqual(modelPhotoMock.link?.absoluteString, URL(string: "www.google.com")?.absoluteString, "The link should be the same from init method")
        XCTAssertNil(modelPhotoMock.media, "The media should be the same from init method")
        XCTAssertEqual(modelPhotoMock.dateTaken, date, "The date taken parameter should be the same from init method")
        XCTAssertEqual(modelPhotoMock._description, "Description", "The description should be the same from init method")
        XCTAssertEqual(modelPhotoMock.published, date, "The published date should be the same from init method")
        XCTAssertEqual(modelPhotoMock.author, "author", "The author should be the same from init method")
        XCTAssertEqual(modelPhotoMock.authorId, "author id", "The author id should be the same from init method")
        XCTAssertEqual(modelPhotoMock.tags, "no tags", "The tags parameter should be the same from init method")
    }

    func testModelFlickrFeed() {
        XCTAssertEqual(modelFeedMock.title, "Title", "The title should be the same from init method")
        XCTAssertEqual(modelFeedMock.link?.absoluteString, URL(string: "www.google.com")?.absoluteString, "The link should be the same from init method")
        XCTAssertEqual(modelFeedMock.modified, date, "The modified date should be the same from init method")
        XCTAssertEqual(modelFeedMock.generator?.absoluteString, URL(string: "www.facebook.com")?.absoluteString, "The link should be the same from init method")
        XCTAssertFalse(modelFeedMock.items?.isEmpty ?? true, "The items should be the same from init method")

        XCTAssertEqual(modelFeedMock.items?.first?.title, modelPhotoMock.title, "The first item should be the model photo created on setup")
    }
}
