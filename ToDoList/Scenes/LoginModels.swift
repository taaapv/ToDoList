//
//  LoginModels.swift
//  ToDoList
//
//  Created by Татьяна on 22.02.2023.
//

import Foundation

enum LoginModels {
	struct Request {
		let email: String
		let password: String
	}
	
	struct Response {
		let success: Bool
		let login: String
		let lastLoginDate: Date
	}
	
	struct ViewModel {
		let success: Bool
		let userName: String
		let lastLoginDate: String
	}
}
