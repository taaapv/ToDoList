//
//  LoginInteractor.swift
//  ToDoList
//
//  Created by Татьяна on 22.02.2023.
//

import Foundation

protocol LoginDataStore {
	var email: String? { get set }
	var password: String? { get set }
}

protocol ILoginInteractor {
	func login(request: LoginModels.Request)
}

class LoginInteractor: ILoginInteractor, LoginDataStore {
	var email: String?
	var password: String?
	
	private var worker: ILoginWorker
	private var presenter: ILoginPresenter?
	
	init(worker: ILoginWorker, presenter: ILoginPresenter) {
		self.worker = worker
		self.presenter = presenter
	}
	
	func login(request: LoginModels.Request) {
		email = request.email
		password = request.password
		
		print(email ?? "no email")
		print(password ?? "no password")
		
		let result = worker.login(
			login: request.email,
			password: request.password
		)
		let response = LoginModels.Response(
			success: result.success == 1,
			login: result.login,
			lastLoginDate: result.lastLoginDate
		)
		presenter?.present(response: response)
	}
}
