//
//  FlickrService.swift
//  Flickr Image Gallery
//
//  Created by Enrique Melgarejo on 15/10/17.
//  Copyright © 2017 Choynowski. All rights reserved.
//

import Foundation

protocol FlickrServiceProtocol: class {
    init(service: ServiceProtocol)
    func requestFeed(completion: ((Data?, Error?) -> Void)?)
}

final class FlickrService: FlickrServiceProtocol {

    private let urlServer = URL(string: "https://api.flickr.com")
    private let currentService: ServiceProtocol
    private let serviceHelper: ServiceHelperProtocol

    required init(service: ServiceProtocol = Service()) {
        self.currentService = service
        self.serviceHelper = ServiceHelper()
    }

    func requestFeed(completion: ((Data?, Error?) -> Void)?) {

        let parameters = ["nojsoncallback": "1", "format": "json", "api_key": "0ca76fda4be91e0e084b40257e939db4"]
        let headers = ["Content-Type": "application/json"]
        let endpoint = "/services/feeds/photos_public.gne"

        guard let url = serviceHelper.buildURL(for: urlServer, pathComponent: endpoint, and: parameters) else {
            completion?(nil, ServiceError.invalidURL(url: urlServer))
            return
        }

        currentService.requestHttp(url: url, method: .get, headers: headers) { data, response, error in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            guard let responseData = data else {
                completion?(nil, ServiceError.responseFailed(reason: ServiceError.ResponseFailureReason.missingObjectSerialization))
                return
            }
            completion?(responseData, nil)
        }
    }
}
