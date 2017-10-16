//
//  FlickrPhotoCollectionViewCell.swift
//  Flickr Image Gallery
//
//  Created by Enrique Melgarejo on 15/10/17.
//  Copyright © 2017 Choynowski. All rights reserved.
//

import UIKit

class FlickrPhotoCollectionViewCell: UICollectionViewCell, BindCellProtocol {

    @IBOutlet weak var imageViewPhoto: UIImageView!
    @IBOutlet weak var labelAuthor: UILabel!

    private var viewModel: FlickrPhotoCellViewModel? {
        didSet {
            clearInformation()
            setupUI()
        }
    }

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

    private func setupUI() {
        labelAuthor.text = viewModel?.author
        imageViewPhoto.loadImage(withURL: viewModel?.media)
    }

    func bind(with viewModel: FlickrPhotoCellViewModel?) {
        self.viewModel = viewModel
    }
}
