//
//  APIService.swift
//  Imgur App
//
//  Created by Humberto Rodrigues on 20/02/23.
//

import Foundation
import UIKit

class ApiService {
    
    private static let basePath = API.imageURL.access
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-Type": "applications/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    private static let session = URLSession(configuration: configuration)
    
    func uploadImage(image: UIImage, completion: @escaping(String?, Error?) -> Void){
        let url = URL(string: ApiService.basePath)
        guard let url = url else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //request.setValue("Client-ID \(API.clientID.access)", forHTTPHeaderField: "Authorization")
        request.setValue("Bearer \(API.accessToken.access)", forHTTPHeaderField: "Authorization")
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let imageData = image.jpegData(compressionQuality: 0.5)
        guard let imageData = imageData else {return}
        let body = NSMutableData() // Criamos uma instancia da classe NSMutableData para representar o Body da requisição
        let fname = "image.jpg" // ------> "\(boundary).jpg"
        let mimetype = "image/jpeg"
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(fname)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8)!)
        //Nesta linha, estamos adicionando uma string ao corpo da requisição para especificar o tipo MIME da parte da imagem.
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
            
        request.httpBody = body as Data //Ja configurado e passado os dados e formato da imagem
        
        let task = ApiService.session.dataTask(with: request) { data, response, error in
            guard let data = data else {return}
            var jsonString = String(data: data, encoding: .utf8)
            completion(jsonString, error)
        }
        task.resume()
    }
}

// MARK: Entendendo Boundary e UUID
//A variável boundary é uma string que é usada como separador entre diferentes partes de um corpo de requisição HTTP multipart/form-data. É uma string única que é gerada aleatoriamente usando a função UUID().uuidString para garantir que não haja colisão com outros separadores.

// A string "boundary" é usada como separador entre as diferentes partes do corpo da requisição HTTP, como a imagem e outras informações adicionais. O UUID é usado para garantir que cada boundary seja único e evite conflitos com outras requisições HTTP que possam estar sendo feitas ao mesmo tempo.

//O UUID garante que o valor seja único e diferente em cada requisição, evitando possíveis conflitos ou erros na transmissão dos dados, como um ID.

// MARK: Entendendo como adicionar informações sobre o tipo de conteúdo e o nome do arquivo imagem
/*

A string "Content-Disposition: form-data" indica que o conteúdo é uma parte de dados de formulário.

A string "name="\image\" indica que o nome da parte da requisição que contém a imagem é "image".

A string "filename=\"(fname)\" indica o nome do arquivo da imagem que estamos enviando. Neste caso, estamos usando a constante "fname", que tem o valor "image.jpg".

A string "\r\n" é um separador de linha usado no formato de mensagem de corpo de requisição multipart.

Ao final, estamos usando o método "data(using: .utf8)" para converter a string para o tipo Data e adicioná-la ao corpo da requisição.
 
Importante lembrar que a declaração correta da sintase é:

 * body.append("Content-Disposition: form-data; name=\"image\"; filename=\"(fname)\"\r\n".data(using: .utf8)!)
 
Anteriormente estavamos declarando como:
 * body.append("Content-Disposition: form-data; name="image"; filename="(fname)"\r\n".data(using: .utf8)!)
 
As barras são necessárias como mostrado acima!!!!!
*/
