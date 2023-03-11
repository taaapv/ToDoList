//
//  LoginAssembler.swift
//  ToDoList
//
//  Created by Татьяна on 11.03.2023.
//

import UIKit

final class LoginAssembler {
	func assembly() -> UIViewController {
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		
		guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
			fatalError("LoginViewController not exist in Main.storyboard")
		}
		
		let worker = LoginWorker()
		let presenter = LoginPresenter(view: loginViewController)
		let interastor = LoginInteractor(worker: worker, presenter: presenter)
		loginViewController.interastor = interastor
		
		return loginViewController
	}
}
