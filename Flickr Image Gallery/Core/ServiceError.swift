//
//  ServiceError.swift
//  Flickr Image Gallery
//
//  Created by Enrique Melgarejo on 15/10/17.
//  Copyright © 2017 Choynowski. All rights reserved.
//

import Foundation

enum ServiceError: Error {

    // TODO: parse all errors

    // The underlying reason the response validation error occurred.
    // - unacceptableStatusCode: The response status code was not acceptable.
    // - missingObjectSerialization: The response object is missing
    enum ResponseFailureReason {
        case unacceptableStatusCode(code: Int)
        case missingObjectSerialization
    }

    case missingInformation
    case invalidURL(url: URL?)
    case responseFailed(reason: ResponseFailureReason)
}
