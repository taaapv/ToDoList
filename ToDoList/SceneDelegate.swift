//
//  SceneDelegate.swift
//  ToDoList
//
//  Created by Татьяна on 11.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)
		
		window.rootViewController = assembly()
		window.makeKeyAndVisible()
		
		self.window = window
	}
	
	private func assembly() -> UIViewController {
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		
		guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
			fatalError("LoginViewController not exist in Main.storyboard")
		}
		
		let worker = LoginWorker()
		let presenter = LoginPresenter(view: loginViewController)
		let interastor = LoginInteractor(worker: worker, presenter: presenter)
		let router = LoginRouter(viewController: loginViewController, dataStore: interastor)
		
		loginViewController.interastor = interastor
		loginViewController.router = router
		
		return loginViewController
	}
}

