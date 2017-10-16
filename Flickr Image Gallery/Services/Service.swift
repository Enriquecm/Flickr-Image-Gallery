//
//  Service.swift
//  Flickr Image Gallery
//
//  Created by Enrique Melgarejo on 15/10/17.
//  Copyright © 2017 Choynowski. All rights reserved.
//

import Foundation

typealias HTTPHeaders = [String: String]
typealias Parameters = [String: Any]
typealias ServiceResponse = ((Data?, URLResponse?, Error?) -> Void)?

public enum HTTPMethod: String {
    case get     = "GET"
    case put     = "PUT"
    case post    = "POST"
    case delete  = "DELETE"
    case options = "OPTIONS"
}

class Service {

    func requestHttp(url: URL, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completion: ServiceResponse) {

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        for (key, value) in (headers ?? [:]) {
            request.addValue(value, forHTTPHeaderField: key)
        }

        for (key, value) in (parameters ?? [:]) {
            // TODO: Put parameters on httpBody when is POST/PUT/DELETE/OPTIONS httpMethods
        }

        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            completion?(data, response, error)
            }.resume()
    }

    func buildURL(for baseURL: URL?, and parameters: Parameters?...) -> URL? {
        guard let url = baseURL?.appendingPathComponent("/services/feeds/photos_public.gne") else { return nil }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)

        if parameters.count > 0 {
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

            let strKey = String(describing: key)
            var strValue = ""

            if let array = value as? [Any] {

                // For array objects
                for (_, arrayValue) in array.enumerated() {
                    let strArrayValue = String(describing: arrayValue)
                    queryItems.append(URLQueryItem(name: strKey, value: strArrayValue))
                }
            } else if !(value is NSNull) {

                // For any objects
                strValue = String(describing: value)
                queryItems.append(URLQueryItem(name: strKey, value: strValue))
            }
        }
        return queryItems
    }
}
