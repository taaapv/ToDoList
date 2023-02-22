//
//  LoginWorker.swift
//  ToDoList
//
//  Created by Татьяна on 22.02.2023.
//

import Foundation

public struct LoginDTO {
	let success: Int
	let login: String
	let lastLoginDate: Date
}

protocol ILoginWorker {
	func login(login: String, password: String) -> LoginDTO
}

class LoginWorker: ILoginWorker {
	func login(login: String, password: String) -> LoginDTO {
		if login == "Admin" && password == "pa$$32!" {
			return LoginDTO(
				success: 1,
				login: login,
				lastLoginDate: Date()
			)
		} else {
			return LoginDTO(
				success: 0,
				login: login,
				lastLoginDate: Date()
			)
		}
	}
}
