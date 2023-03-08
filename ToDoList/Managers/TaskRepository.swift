//
//  Repository.swift
//  ToDoList
//
//  Created by Татьяна on 15.02.2023.
//

import Foundation

/// Protocol of Task Repository
protocol ITaskRepository {
	
	/// create Tasks from repository
	/// - Returns: created tasks
	func createTasks() -> [Task]
}

/// Class Task Repository with stub data
class TaskRepositoryStub: ITaskRepository {
	
	/// create stub Tasks from repository
	/// - Returns: created stub tasks
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
