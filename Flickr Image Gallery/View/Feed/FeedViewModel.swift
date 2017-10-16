//
//  FeedViewModel.swift
//  Flickr Image Gallery
//
//  Created by Enrique Melgarejo on 14/10/17.
//  Copyright © 2017 Choynowski. All rights reserved.
//

import Foundation

final class FeedViewModel: NSObject {

    // MARK: Properties
    let title = "Public Feed"

    private var photos: [ModelFlickrPhoto]? {
        didSet {
            var viewModels = [FlickrPhotoCellViewModel]()
            photos?.forEach({ viewModels.append(FlickrPhotoCellViewModel(photo: $0)) })
            dataSource = viewModels
        }
    }
    
    private(set) var dataSource: [FlickrPhotoCellViewModel] = [] {
        didSet {
            onDataSourceChanged?()
        }
    }

    // MARK: Reactors
    var onDataSourceChanged: (() -> Void)?
    var onDataSourceFailed: ((Error?) -> Void)?
    var onFlickrPhotoSelected: ((FlickrPhotoCellViewModel) -> Void)?

    internal let flickrService: FlickrServiceProtocol

    init(flickrService: FlickrServiceProtocol = FlickrService()) {
        self.flickrService = flickrService
    }

    func loadFeed() {
        flickrService.requestFeed { [weak self] (data, error) in
            guard let data = data, error == nil else {
                self?.onDataSourceFailed?(error)
                return
            }

            let feedParser = Parser<ModelFlickrFeed>()
            let feed = try? feedParser.parse(from: data, with: feedParser.dateDecodingStrategy())
            if let feed = feed {
                self?.photos = feed.items ?? []
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

    func data(for indexPath: IndexPath) -> FlickrPhotoCellViewModel? {
        let row = indexPath.row
        guard row < dataSource.count else { return nil }
        return dataSource[row]
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard let photo = data(for: indexPath) else { return }
        onFlickrPhotoSelected?(photo)
    }
}
