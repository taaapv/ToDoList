//
//  LoginPresenter.swift
//  ToDoList
//
//  Created by Татьяна on 22.02.2023.
//

import Foundation

protocol ILoginPresenter {
	func present(response: LoginModels.Response)
}

class LoginPresenter: ILoginPresenter {
	private weak var view: ILoginViewController?
	
	init(view: ILoginViewController) {
		self.view = view
	}
	
	func present(response: LoginModels.Response) {
		let viewModel: LoginModels.ViewModel = response.success ?
			.success :
			.failure("Wrong login or password!")
		view?.render(viewModel: viewModel)
	}
}
