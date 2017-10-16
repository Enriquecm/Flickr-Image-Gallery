//
//  ImageCache.swift
//  Flickr Image Gallery
//
//  Created by Enrique Melgarejo on 16/10/17.
//  Copyright © 2017 Choynowski. All rights reserved.
//

import UIKit

final class ImageCache {

    static let shared = ImageCache()

    private let imageCache = NSCache<NSString, AnyObject>()

    func cachedImage(forKey key: String?) -> UIImage? {
        guard let key = key else { return nil }
        let image = imageCache.object(forKey: key as NSString)
        return image as? UIImage
    }

    func set(image: UIImage?, forKey key: String?) {
        guard let image = image, let key = key else { return }
        imageCache.setObject(image, forKey: key as NSString)
    }
}
