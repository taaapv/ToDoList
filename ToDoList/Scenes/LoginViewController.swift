//
//  LoginViewController.swift
//  ToDoList
//
//  Created by Татьяна on 22.02.2023.
//

import UIKit

protocol ILoginViewController: AnyObject {
	func render(viewModel: LoginModels.ViewModel)
}

class LoginViewController: UIViewController {
	
	@IBOutlet weak var loginTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
	var interastor: ILoginInteractor?
	var router: (NSObjectProtocol & ILoginRouter & LoginRouterDataPassing)?
	
	@IBAction func loginButtonTapped(_ sender: UIButton) {
		if let login = loginTextField.text, let password = passwordTextField.text {
			let request = LoginModels.Request(
				email: login,
				password: password
			)
			interastor?.login(request: request)
		}
	}
}

extension LoginViewController: ILoginViewController {
	func render(viewModel: LoginModels.ViewModel) {
		switch viewModel.success {
		case true:
			router?.routeToTaskList()
		case false:
			let alert = UIAlertController(
				title: "Failure!",
				message: "User did not exist",
				preferredStyle: .alert
			)
			let action = UIAlertAction(title: "OK", style: .default)
			alert.addAction(action)
			present(alert, animated: true)
		}
	}
}
