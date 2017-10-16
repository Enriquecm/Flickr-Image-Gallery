//
//  FeedViewModel.swift
//  Flickr Image Gallery
//
//  Created by Enrique Melgarejo on 14/10/17.
//  Copyright © 2017 Choynowski. All rights reserved.
//

import Foundation

class FeedViewModel: NSObject {

    // MARK: Properties
    private(set) var dataSource: [ModelFlickrPhoto] {
        didSet {
            onDataSourceChanged?()
        }
    }

    // MARK: Reactors
    var onDataSourceChanged: (() -> Void)?
    var onDataSourceFailed: ((Error?) -> Void)?
    var onFlickrPhotoSelected: ((ModelFlickrPhoto) -> Void)?

    let flickrService: FlickrServiceProtocol

    init(flickrService: FlickrServiceProtocol = FlickrService()) {
        self.flickrService = flickrService
        self.dataSource = []
    }

    func loadFeed() {
        flickrService.requestFeed { [weak self] feed, error in
            if let feed = feed, error == nil {
                self?.dataSource = feed.items ?? []
            } else if error != nil {
                self?.onDataSourceFailed?(error)
            } else {
                self?.onDataSourceFailed?(ServiceError.missingInformation)
            }
        }
    }

    // MARK: Data source methods
    func numberOfSections() -> Int {
        return 1
    }

    func numberOfItemsInSection(for section: Int) -> Int {
        return dataSource.count
    }

    func identifier(for indexPath: IndexPath) -> String {
        return FlickrPhotoCollectionViewCell.identifier
    }

    func data(for indexPath: IndexPath) -> ModelFlickrPhoto? {
        let row = indexPath.row
        guard row < dataSource.count else { return nil }
        return dataSource[row]
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard let photo = data(for: indexPath) else { return }
        onFlickrPhotoSelected?(photo)
    }
}
