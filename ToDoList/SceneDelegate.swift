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
		let loginViewController = LoginAssembler().assembly()
		let taskListViewController = TaskListAssembler().assembly()
		
		let router = LoginRouter(
			loginViewController: loginViewController,
			taskListViewController: taskListViewController
		)
		
		if let loginViewController = loginViewController as? LoginViewController {
			loginViewController.router = router
		}
		return loginViewController
	}
}

