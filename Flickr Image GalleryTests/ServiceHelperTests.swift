//
//  ServiceHelperTests.swift
//  Flickr Image GalleryTests
//
//  Created by Enrique Melgarejo on 16/10/17.
//  Copyright © 2017 Choynowski. All rights reserved.
//

import XCTest
@testable import Flickr_Image_Gallery

class ServiceHelperTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testBuildURL() {
        let serviceHelper: ServiceHelperProtocol = ServiceHelper()

        let urlServer = URL(string: "https://api.flickr.com")
        let parameters = ["nojsoncallback": "1", "format": "json", "api_key": "0ca76fda4be91e0e084b40257e939db4"]
        let endpoint = "/services/feeds/photos_public.gne"

        let url = serviceHelper.buildURL(for: urlServer, pathComponent: endpoint, and: parameters)
        XCTAssertNotNil(url, "The url should not be nil.")
        XCTAssertEqual(url?.pathComponents.count, 4, "The url should have 4 path components")

        let expectedUrl = "https://api.flickr.com/services/feeds/photos_public.gne?api_key=0ca76fda4be91e0e084b40257e939db4&format=json&nojsoncallback=1"
        XCTAssertEqual(url?.absoluteString, expectedUrl, "The url should be equal to expected URL")
    }
}
