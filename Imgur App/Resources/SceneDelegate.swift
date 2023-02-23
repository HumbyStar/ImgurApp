//
//  SceneDelegate.swift
//  Imgur App
//
//  Created by Humberto Rodrigues on 20/02/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        let navigation = UINavigationController(rootViewController: ViewController())
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {return}
        
        if url.scheme == "imgur" &&  url.host == "oauth" {
            let code = url.absoluteString.components(separatedBy: "code=").last
            //com url.absoluteString, podemos analisar a string de URL e acessar suas componentes, como o esquema, o host, a porta, o caminho, os parâmetros de consulta, etc. Isso é útil na extração de informações relevantes da resposta da API, como o código de autorização ou o token de acesso.
            
            // No .last eu separei a string usando .componentes(Coloquei de onde separar "code=") e depois falei que quero a .last parte ou seja o que vier depois de "code="
            
            UserDefaults.standard.set(code, forKey: "authToken")
            NotificationCenter.default.post(name: NSNotification.Name("refresh"), object: nil)
        }
    }


}

