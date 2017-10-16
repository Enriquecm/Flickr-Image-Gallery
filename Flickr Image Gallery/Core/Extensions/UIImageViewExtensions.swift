//
//  UIImageViewExtensions.swift
//  Flickr Image Gallery
//
//  Created by Enrique Melgarejo on 15/10/17.
//  Copyright © 2017 Choynowski. All rights reserved.
//

import UIKit

extension UIImageView {

    func loadImage(withURL url: URL?) {
        if let cachedImage = ImageCache.shared.cachedImage(forKey: url?.absoluteString) {
            image = cachedImage
            return
        }
        DispatchQueue.global().async {
            if let url = url, let data = try? Data(contentsOf: url) {
                let image = UIImage(data: data)
                ImageCache.shared.set(image: image, forKey: url.absoluteString)

                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
