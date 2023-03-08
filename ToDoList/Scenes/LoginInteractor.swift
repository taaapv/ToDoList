//
//  LoginInteractor.swift
//  ToDoList
//
//  Created by Татьяна on 22.02.2023.
//

import Foundation

protocol ILoginDataStore {
	var email: String { get set }
	var password: String { get set }
}

protocol ILoginInteractor {
	func login(request: LoginModels.Request)
}

class LoginInteractor: ILoginInteractor, ILoginDataStore {
	var email = ""
	var password = ""
	
	private var worker: ILoginWorker
	private var presenter: ILoginPresenter?
	
	init(worker: ILoginWorker, presenter: ILoginPresenter) {
		self.worker = worker
		self.presenter = presenter
	}
	
	func login(request: LoginModels.Request) {
		email = request.email
		password = request.password
		
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
