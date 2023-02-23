//
//  Dictionary + query.swift
//  Imgur App
//
//  Created by Humberto Rodrigues on 22/02/23.
//

import Foundation

extension Dictionary where Key == String, Value == String {
    var queryEncondedString: String {
        var parts = [String]()
        for (key,value) in self {
            let queryPart = "\(key)=\(value)"
            parts.append(queryPart)
        }
        return parts.joined(separator: "&")
    }
}
