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
	}
	
	enum ViewModel {
		case success
		case failure(String)
	}
}
