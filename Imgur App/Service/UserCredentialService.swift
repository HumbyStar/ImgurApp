//
//  UserCredentialService.swift
//  Imgur App
//
//  Created by Humberto Rodrigues on 22/02/23.
//

import Foundation
import UIKit

class UserCredentialService {

    let userCredentials = UserCredentials()
    
    private static let urlSessionConfiguration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = [
            "Content-Type":"application/x-www-form-urlencoded", //requisição HTTP HTML
            "Accept":"*/*", //aceita qualquer tipo de resposta
            "Authorization":"Bearer \(API.accessToken.access)"
        ]
        return configuration
    }()
    
    static let session = URLSession(configuration: urlSessionConfiguration)
       
    func getUrlRequest(withMethod method: String = "GET", url: String) -> URLRequest? {
        let url = URL(string: url)
        guard let url = url else {return nil}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        return urlRequest
    }

    func getAuthorize() {
        let parameters = [
            "client_id": API.clientID.access,
            "response_type": "code",
            "state": UserCredentials.state,
            
        ]
        let queryString = parameters.map({"\($0)=\($1)"}).joined(separator: "&")
        let urlWithParams = "\(UserCredentials.urlAuthorize)?\(queryString)"
        
        if let url = URL(string: urlWithParams) {
            UIApplication.shared.open(url)
        }
        
        //O Erro 403 é referente a token expirado(não é valido). Quando o erro 403 acontecer, UserCredentials.code == ""
    }
    
    func getTokens() {
        let urlRequest = getUrlRequest(withMethod: "POST", url: UserCredentials.urlToken)
        guard var urlRequest = urlRequest else {return}
        let parameters = [
            "grant_type":"authorization_code",
            "client_id": API.clientID.access,
            "client_secret": API.clientSecret.access,
            "code": userCredentials.code!,
            "redirect_uri": userCredentials.redirectUri
        ]
        
        guard let httpBody = parameters.queryEncondedString.data(using: .utf8) else {return}
        urlRequest.httpBody = httpBody
        
        let task = UserCredentialService.session.dataTask(with: urlRequest) { data, response, error in
            if error == nil {
                guard let data = data else {return}
                print("data sucess")
                let dataString = String(data: data, encoding: .utf8)
                guard let urlResponse = response as? HTTPURLResponse else {return}
                print("url response success")
                if urlResponse.statusCode == 200 {
                    do {
                        let responseAuthorization = try JSONDecoder().decode(ResponseAuthorization.self, from: data)
                        guard let refreshToken = responseAuthorization.refresh_token, let accessToken = responseAuthorization.access_token else {return}
                        UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
                        UserDefaults.standard.set(accessToken, forKey: "accessToken")
                        
                    } catch {
                        print(error)
                    }
                } else {
                    print("Código não é 200: \(urlResponse.statusCode)")
                }
            } else {
                print("Error \(Self.self)")
                print(error)
            }
        }
        task.resume()
    }
    
    
    
}
