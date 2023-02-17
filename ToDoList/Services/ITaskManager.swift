//
//  ITaskManager.swift
//  ToDoList
//
//  Created by Татьяна on 18.02.2023.
//

import Foundation

protocol ITaskManager {
	func getTaskList() -> [Task]
	func getComletedTaskList() -> [Task]
	func getNotComletedTaskList() -> [Task]
	func addTasksToTaskList(tasks: [Task])
}

extension TaskManager: ITaskManager {}

extension ImportantTask.Priority: CustomStringConvertible {
	var description: String {
		switch self {
		case .low:
			return "!"
		case .medium:
			return "!!"
		case .high:
			return "!!!"
		}
	}
	
	
}
