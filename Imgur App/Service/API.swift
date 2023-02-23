//
//  API.swift
//  Imgur App
//
//  Created by Humberto Rodrigues on 20/02/23.
//

import Foundation

enum API {
    case myURL
    case galleryURL
    case galleryTagURL
    case galleryTags
    case imageURL
    case clientID
    case clientSecret
    case accessToken
    case refreshToken
    
    var access: String {
        switch self {
        case .myURL:
            return "https://api.imgur.com/3/account/user_id"
        case .galleryURL:
            return "https://api.imgur.com/3/gallery/hot/viral/1"
        case .galleryTagURL:
            return "https://api.imgur.com/3/gallery/t/"
        case .galleryTags:
            return "https://api.imgur.com/3/tags"
        case .imageURL:
            return "https://api.imgur.com/3/image/"
        case .clientID:
            return "0726f39f789f729"
        case .clientSecret:
            return "117e36ae733610fbbc48f10d2a8b857b54f2474b"
        case .refreshToken:
            return "57d547757e9c8ff4455cd794dc489350c5da392b"
        case .accessToken:
            return "36f4276ee9e32e8edcde94ae61802b5b0b40c0ec"
        }
        
    }
}
