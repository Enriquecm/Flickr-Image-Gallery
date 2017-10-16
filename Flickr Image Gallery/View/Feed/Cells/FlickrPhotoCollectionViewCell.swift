//
//  FlickrPhotoCollectionViewCell.swift
//  Flickr Image Gallery
//
//  Created by Enrique Melgarejo on 15/10/17.
//  Copyright © 2017 Choynowski. All rights reserved.
//

import UIKit

class FlickrPhotoCollectionViewCell: UICollectionViewCell, SetupCellProtocol {

    @IBOutlet weak var imageViewPhoto: UIImageView!
    @IBOutlet weak var labelAuthor: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        clearInformation()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        clearInformation()
    }

    private func clearInformation() {
        labelAuthor.text = ""
        imageViewPhoto.image = nil
    }

    func setup(with model: ModelFlickrPhoto?) {
        clearInformation()
        labelAuthor.text = model?.author?.formatFlickrAuthor()
        imageViewPhoto.loadImage(withURL: model?.media)
    }
}

private extension String {

    func formatFlickrAuthor() -> String? {
        let author = self.slice(from: "(\"", to: "\")")
        return author
    }
}
