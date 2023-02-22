//
//  LoginRouter.swift
//  ToDoList
//
//  Created by Татьяна on 22.02.2023.
//

import Foundation
import UIKit

@objc protocol ILoginRouter {
	func routeToTaskList(segue: UIStoryboardSegue?)
}

protocol LoginRouterDataPassing {
	var dataStore: LoginDataStore? { get}
}

class LoginRouter: NSObject, ILoginRouter, LoginRouterDataPassing {
	weak var viewController: LoginViewController?
	var dataStore: LoginDataStore?
	
	init(viewController: LoginViewController, dataStore: LoginDataStore) {
		self.viewController = viewController
		self.dataStore = dataStore
	}
	
	func routeToTaskList(segue: UIStoryboardSegue?) {
		if let segue = segue {
			let destinationVC = segue.destination as! TaskListViewController
			var destinationDS = destinationVC.router!.dataStore!
			passDataToTaskList(sourse: dataStore!, destination: &destinationDS)
		} else {
			let storyboard = UIStoryboard(name: "Main", bundle: nil)
			let destinationVC = storyboard.instantiateViewController(withIdentifier: "TaskListViewController") as! TaskListViewController
			var destinationDS = destinationVC.router!.dataStore!
			passDataToTaskList(sourse: dataStore!, destination: &destinationDS)
			navigateToTaskList(sourse: viewController!, destination: destinationVC)
		}
	}
	
	private func navigateToTaskList(sourse: LoginViewController, destination: TaskListViewController) {
		sourse.show(destination, sender: nil)
	}
	
	private func passDataToTaskList(sourse: LoginDataStore, destination: inout TaskListDataStore) {
		destination.email = sourse.email
		destination.password = sourse.password
	}
}
