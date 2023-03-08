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
}

protocol LoginRouterDataPassing {
	var dataStore: ILoginDataStore? { get}
}

class LoginRouter: NSObject, ILoginRouter, LoginRouterDataPassing {
	weak var viewController: LoginViewController?
	var dataStore: ILoginDataStore?
	
	init(viewController: LoginViewController, dataStore: ILoginDataStore) {
		self.viewController = viewController
		self.dataStore = dataStore
	}
	
	func routeToTaskList() {
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		let destinationVC = storyboard.instantiateViewController(withIdentifier: "TaskListViewController") as! TaskListViewController
		var destinationDS = destinationVC.router!.dataStore!
		passDataToTaskList(sourse: dataStore!, destination: &destinationDS)
		navigateToTaskList(sourse: viewController!, destination: destinationVC)
	}
	
	private func navigateToTaskList(sourse: LoginViewController, destination: TaskListViewController) {
		sourse.navigationController?.pushViewController(destination, animated: true)
	}
	
	private func passDataToTaskList(sourse: ILoginDataStore, destination: inout ITaskListDataStore) {
		destination.email = sourse.email
		destination.password = sourse.password
	}
}
