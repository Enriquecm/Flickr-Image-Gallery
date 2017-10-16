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
    case get = "GET"
}

protocol ServiceProtocol: class {
    func requestHttp(url: URL, method: HTTPMethod, headers: HTTPHeaders?, completion: ServiceResponse)
}

final class Service: ServiceProtocol {

    func requestHttp(url: URL, method: HTTPMethod = .get, headers: HTTPHeaders? = nil, completion: ServiceResponse) {

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        for (key, value) in (headers ?? [:]) {
            request.addValue(value, forHTTPHeaderField: key)
        }

        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            completion?(data, response, error)
            }.resume()
    }
}
