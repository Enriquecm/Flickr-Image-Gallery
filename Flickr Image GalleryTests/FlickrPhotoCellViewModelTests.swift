//
//  FlickrPhotoCellViewModelTests.swift
//  Flickr Image GalleryTests
//
//  Created by Enrique Melgarejo on 16/10/17.
//  Copyright © 2017 Choynowski. All rights reserved.
//

import XCTest
@testable import Flickr_Image_Gallery

class FlickrPhotoCellViewModelTests: XCTestCase {

    private var modelPhotoMock: ModelFlickrPhoto!
    private let date = Date(timeIntervalSince1970: 1000000)

    override func setUp() {
        super.setUp()
        modelPhotoMock = ModelFlickrPhoto(title: "Photo", link: nil, media: URL(string: "www.google.com"), dateTaken: date, _description: "Description", published: date, author: "(\"author\")", authorId: "author id", tags: "no tags")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInitialization() {
        let viewModel = FlickrPhotoCellViewModel(photo: modelPhotoMock)
        XCTAssertNotNil(viewModel, "The view model should not be nil.")
        XCTAssertEqual(viewModel.author, "author", "The author should be the same from init method")
        XCTAssertEqual(viewModel.media?.absoluteString, URL(string: "www.google.com")?.absoluteString, "The media should be the same from init method")
    }
}
