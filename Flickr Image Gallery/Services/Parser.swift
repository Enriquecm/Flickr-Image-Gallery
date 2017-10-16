//
//  Parser.swift
//  Flickr Image Gallery
//
//  Created by Enrique Melgarejo on 16/10/17.
//  Copyright © 2017 Choynowski. All rights reserved.
//

import Foundation

final class Parser<T> where T: Decodable {

    func parse(from responseData: Data, with dateDecodingStrategy: JSONDecoder.DateDecodingStrategy) throws -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        let decoded = try decoder.decode(T.self, from: responseData)
        return decoded
    }

    func dateDecodingStrategy() -> JSONDecoder.DateDecodingStrategy {
        if #available(iOS 10.0, *) {
            return .iso8601
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            return .formatted(dateFormatter)
        }
    }
}
