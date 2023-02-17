//
//  Repository.swift
//  ToDoList
//
//  Created by Татьяна on 15.02.2023.
//

import Foundation

protocol ITaskRepository {
	func createTasks() -> [Task]
}

class TaskRepositoryStub: ITaskRepository {
	func createTasks() -> [Task] {
		[
			RegularTask(completed: true, title: "Task1"),
			ImportantTask(title: "Task2", priority: .low),
			RegularTask(title: "Task3"),
			RegularTask(completed: true, title: "Task4"),
			ImportantTask(completed: true, title: "Task5", priority: .high),
			ImportantTask(completed: false, title: "Task6", priority: .medium)
		]
	}
}
