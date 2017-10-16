//
//  FlickrService.swift
//  Flickr Image Gallery
//
//  Created by Enrique Melgarejo on 15/10/17.
//  Copyright © 2017 Choynowski. All rights reserved.
//

import Foundation

class FlickrService {

    private let urlServer = URL(string: "https://api.flickr.com")
    private let currentService: Service

    init(service: Service = Service()) {
        self.currentService = service
    }

    func requestFeed(completion: ((ModelFlickrFeed?, Error?) -> Void)?) {

        let parameters = ["format": "json", "api_key": "0ca76fda4be91e0e084b40257e939db4"]
        let headers = ["Content-Type": "application/json"]

        guard let url = currentService.buildURL(for: urlServer, and: parameters) else {
            completion?(nil, ServiceError.invalidURL(url: urlServer))
            return
        }

        currentService.requestHttp(url: url, method: .get, headers: headers) { (data, response, error) in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            guard let responseData = data else {
                completion?(nil, ServiceError.responseFailed(reason: ServiceError.ResponseFailureReason.missingObjectSerialization))
                return
            }

            guard let feed = try? JSONDecoder().decode(ModelFlickrFeed.self, from: responseData) else {
                completion?(nil, ServiceError.responseFailed(reason: ServiceError.ResponseFailureReason.missingObjectSerialization))
                return
            }

            completion?(feed, nil)
        }
    }
}
