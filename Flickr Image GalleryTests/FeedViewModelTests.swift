//
//  FeedViewModelTests.swift
//  Flickr Image GalleryTests
//
//  Created by Enrique Melgarejo on 16/10/17.
//  Copyright © 2017 Choynowski. All rights reserved.
//

import XCTest
@testable import Flickr_Image_Gallery

class FeedViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitialization() {
        let viewModel = FeedViewModel()
        XCTAssertNotNil(viewModel, "The view model should not be nil.")
        XCTAssertTrue(viewModel.dataSource.isEmpty, "The dataSource should start empty.")

        let flickrService = FlickrServiceMock()
        let feedViewModel = FeedViewModel(flickrService: flickrService)
        XCTAssertNotNil(feedViewModel, "The view model should not be nil.")
        XCTAssertTrue(feedViewModel.flickrService === flickrService, "The service should be equal to the service that was passed in.")
    }

    func testMethods() {
        let flickrService = FlickrServiceMock()
        let feedViewModel = FeedViewModel(flickrService: flickrService)
        feedViewModel.loadFeed()
        XCTAssertTrue(flickrService.didRequest, "The request method should be called.")
    }

    func testDataSourceMethods() {
        let viewModel = FeedViewModel()
        XCTAssertEqual(viewModel.numberOfSections(), 1, "The number of sections should be 1")
        XCTAssertEqual(viewModel.numberOfItemsInSection(for: 0), 0 , "The number of items in section 0 should be 0")

        let indexPath1 = IndexPath(item: 0, section: 0)
        let indexPath2 = IndexPath(item: 1, section: 0)
        XCTAssertEqual(viewModel.identifier(for: indexPath1), FlickrPhotoCollectionViewCell.identifier , "The identifier should be FlickrPhotoCollectionViewCell for all indexPath's")
        XCTAssertEqual(viewModel.identifier(for: indexPath2), FlickrPhotoCollectionViewCell.identifier , "The identifier should be FlickrPhotoCollectionViewCell for all indexPath's")
        XCTAssertNil(viewModel.data(for: indexPath1), "The data should be nil before load information")
        XCTAssertNil(viewModel.data(for: indexPath2), "The data should be nil before load information")
    }
}

private class ServiceMock: ServiceProtocol {
    var didRequest = false
    var requestedUrl: URL?
    var requestMethod: HTTPMethod?
    var requestedHeaders: HTTPHeaders?

    func requestHttp(url: URL, method: HTTPMethod, headers: HTTPHeaders?, completion: ServiceResponse) {
        didRequest = true
        requestedUrl = url
        requestMethod = method
        requestedHeaders = headers
    }
}

private class FlickrServiceMock: FlickrServiceProtocol {

    var didRequest = false
    private var currentService: ServiceProtocol

    required init(service: ServiceProtocol = ServiceMock()) {
        self.currentService = service
    }

    func requestFeed(completion: ((Data?, Error?) -> Void)?) {
        didRequest = true
    }
}

