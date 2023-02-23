//
//  AppDelegate.swift
//  Imgur App
//
//  Created by Humberto Rodrigues on 20/02/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        NotificationCenter.default.addObserver(forName: NSNotification.Name("refresh"), object: nil, queue: nil) { notification in
//            let vc = ViewController() -- NAO DEU CERTO PORQUE EU ESTAVA INSTANCIADO UMA VIEWCONTROLLER EM CIMA DA OUTRA
//            vc.validate()
        //}
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        print("AAAAAAAAAAAAAAAAAAAAA")
//        if url.scheme == "imgur" &&  url.host == "oauth" {
//            let code = url.absoluteString.components(separatedBy: "code=").last
//            //com url.absoluteString, podemos analisar a string de URL e acessar suas componentes, como o esquema, o host, a porta, o caminho, os parâmetros de consulta, etc. Isso é útil na extração de informações relevantes da resposta da API, como o código de autorização ou o token de acesso.
//            
//            // No .last eu separei a string usando .componentes(Coloquei de onde separar "code=") e depois falei que quero a .last parte ou seja o que vier depois de "code="
//            
//            UserDefaults.standard.set(code, forKey: "authToken")
//        }
//        return true
//    }


}

