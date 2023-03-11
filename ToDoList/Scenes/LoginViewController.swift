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
	var router: ILoginRouter?
	
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
		switch viewModel {
		case .success:
			router?.routeToTaskList()
		case .failure(let message):
			router?.showError(with: message)
		}
	}
}
