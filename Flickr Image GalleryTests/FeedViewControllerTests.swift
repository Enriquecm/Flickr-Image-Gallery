//
//  FeedViewControllerTests.swift
//  Flickr Image GalleryTests
//
//  Created by Enrique Melgarejo on 16/10/17.
//  Copyright © 2017 Choynowski. All rights reserved.
//

import XCTest
@testable import Flickr_Image_Gallery

class FeedViewControllerTests: XCTestCase {

    private let storyboard = UIStoryboard(name: "Main", bundle: nil)
    private var feedViewController: FeedViewController?

    override func setUp() {
        super.setUp()
        feedViewController = storyboard.instantiateViewController(withIdentifier: "FeedViewController") as? FeedViewController
        let _ = feedViewController?.view //ensure viewDidLoad gets called
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUIInformation() {
        XCTAssertEqual(feedViewController?.title, "Public Feed")
    }
}
