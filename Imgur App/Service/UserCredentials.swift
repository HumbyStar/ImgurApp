//
//  Credentials.swift
//  Imgur App
//
//  Created by Humberto Rodrigues on 22/02/23.
//

import Foundation

class UserCredentials {
    var accessToken: String? = UserDefaults.standard.string(forKey: "accessToken")
    var refreshToken: String? = UserDefaults.standard.string(forKey: "refreshToken")
    var code: String? = UserDefaults.standard.string(forKey: "authToken")
    // Code é um token temporário, ele é uma moeda de troca para obter refreshToken e AccessToken, por isso eu preciso dele.
    
    static let urlToken =  "https://api.imgur.com/oauth2/token"
    static let urlAuthorize = "https://api.imgur.com/oauth2/authorize"
    static let state = "APPLICATION_STATE"
    
    let redirectUri = "imgur://oauth"
    
}
