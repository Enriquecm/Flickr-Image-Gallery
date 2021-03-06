//
//  ServiceHelper.swift
//  Flickr Image Gallery
//
//  Created by Enrique Melgarejo on 16/10/17.
//  Copyright © 2017 Choynowski. All rights reserved.
//

import Foundation

protocol ServiceHelperProtocol {
    func buildURL(for baseURL: URL?, pathComponent: String, and parameters: Parameters?...) -> URL?
}

struct ServiceHelper: ServiceHelperProtocol {

    func buildURL(for baseURL: URL?, pathComponent: String, and parameters: Parameters?...) -> URL? {
        guard let url = baseURL?.appendingPathComponent(pathComponent) else { return nil }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)

        if !parameters.isEmpty {
            var queryItems: [URLQueryItem] = components?.queryItems ??  []
            for params in parameters {
                queryItems.append(contentsOf: buildQueryItems(parameters: params))
            }
            components?.queryItems = queryItems
        }
        return components?.url
    }

    private func buildQueryItems(parameters: Parameters?) -> [URLQueryItem] {
        guard let parameters = parameters else { return [] }

        var queryItems: [URLQueryItem] = []
        for (key, value) in parameters {

            let queryName = String(describing: key)
            var queryValue = ""

            if let array = value as? [Any] {

                // For array objects
                for (_, arrayValue) in array.enumerated() {
                    let queryArrayValue = String(describing: arrayValue)
                    queryItems.append(URLQueryItem(name: queryName, value: queryArrayValue))
                }
            } else if !(value is NSNull) {

                // For any objects
                queryValue = String(describing: value)
                queryItems.append(URLQueryItem(name: queryName, value: queryValue))
            }
        }
        return queryItems
    }
}
