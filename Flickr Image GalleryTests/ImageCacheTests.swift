//
//  ImageCacheTests.swift
//  Flickr Image GalleryTests
//
//  Created by Enrique Melgarejo on 16/10/17.
//  Copyright © 2017 Choynowski. All rights reserved.
//

import XCTest
@testable import Flickr_Image_Gallery

class ImageCacheTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testImageCache() {
        let imageCache = ImageCache.shared
        XCTAssertNotNil(imageCache, "The image cache should not be nil.")
        let image = UIImage()
        imageCache.set(image: image, forKey: "imageKey")

        let cachedImage = imageCache.cachedImage(forKey: "imageKey")
        XCTAssertEqual(cachedImage, image, "The images should be the same.")
    }
}
