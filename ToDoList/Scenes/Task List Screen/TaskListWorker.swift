//
//  TaskListWorker.swift
//  ToDoList
//
//  Created by Татьяна on 03.03.2023.
//

import Foundation

protocol ITaskListWorker {
	func createTasks() -> [Task]
}

class TaskListWorker: ITaskListWorker {
	func createTasks() -> [Task] {
		let repository: ITaskRepository = TaskRepositoryStub()
		let tasks = repository.createTasks()
		return tasks
	}
}
