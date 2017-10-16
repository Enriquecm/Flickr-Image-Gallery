//
//  ServiceTests.swift
//  Flickr Image GalleryTests
//
//  Created by Enrique Melgarejo on 16/10/17.
//  Copyright © 2017 Choynowski. All rights reserved.
//

import XCTest
@testable import Flickr_Image_Gallery

class ServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testService() {
        let service = ServiceMock()
        let url = URL(string: "www.google.com.br")
        let method = HTTPMethod.get
        let headers = ["theHeader": "theHeaderValue"]
        service.requestHttp(url: url!, method: method, headers: headers, completion: nil)

        XCTAssertTrue(service.didRequest, "The request method should be called")
        XCTAssertEqual(service.requestedUrl, url, "The service url should be equal to the url that was passed in.")
        XCTAssertTrue(service.requestMethod == .get, "The service method should be equal to the method that was passed in.")
        XCTAssertEqual(service.requestedHeaders?.count, headers.count, "The service headers should be equal to the headers that was passed in.")
    }

    func testFlickrService() {
        let flickrService = FlickrServiceMock()
        flickrService.requestFeed(completion: nil)
        XCTAssertTrue(flickrService.didRequest, "The request method should be called")
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
