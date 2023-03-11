//
//  LoginRouter.swift
//  ToDoList
//
//  Created by Татьяна on 22.02.2023.
//

import Foundation
import UIKit

@objc protocol ILoginRouter {
	func routeToTaskList()
	func showError(with message: String)
}

class LoginRouter: NSObject, ILoginRouter {
	private weak var loginViewController: UIViewController!
	private let taskListViewController: UIViewController
	
	init(loginViewController: UIViewController, taskListViewController: UIViewController) {
		self.loginViewController = loginViewController
		self.taskListViewController = taskListViewController
	}
	
	func routeToTaskList() {
		loginViewController.present(taskListViewController, animated: true)
	}
	
	func showError(with message: String) {
		let alert = UIAlertController(
			title: "Failure!",
			message: message,
			preferredStyle: .alert
		)
		let action = UIAlertAction(title: "OK", style: .default)
		alert.addAction(action)
		loginViewController.present(alert, animated: true)
	}
}
