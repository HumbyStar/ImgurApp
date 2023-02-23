//
//  ViewController.swift
//  Imgur App
//
//  Created by Humberto Rodrigues on 20/02/23.
//

import UIKit

class ViewController: UIViewController {

//    var apiService = ApiService()
//    var testImg = UIImage(named: "player3")
    var userCredentialService = UserCredentialService()
    var validateApp = ValidateApp()
    
    override func loadView() {
        super.loadView()
        
        self.view = validateApp
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
//        apiService.uploadImage(image: testImg!) { jsonString, error in
//            print(jsonString, error)
//        }
        validateApp.delegate(delegate: self)
        
        validate()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("refresh"), object: nil, queue: nil) { notification in
            self.validate()
        }
    }

    func validate() {
        //chamar segunda viewController para fazer essa validação de forma modally
        print(userCredentialService.userCredentials.code)
            guard let _ = self.userCredentialService.userCredentials.code?.isEmpty else {
                self.validateApp.lbStatus.text = "Não Autorizado"
                return
            }
            self.loadViewIfNeeded()
            self.validateApp.lbStatus.text = "Autorizado"
    }


}

extension ViewController: AuthorizeDelegate {
    func getAuthorization() {
        userCredentialService.getAuthorize()
    }
}
