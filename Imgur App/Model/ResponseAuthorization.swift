//
//  ResponseAuthorization.swift
//  Imgur App
//
//  Created by Humberto Rodrigues on 22/02/23.
//

import Foundation

class ResponseAuthorization: Codable {
    var access_token: String?
    var expires_in: Int?
    var token_type: String?
    var scope: String?
    var refresh_token: String?
    var account_id: Float?
    var account_username: String?
}


