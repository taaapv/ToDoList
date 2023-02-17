//
//  OrderedTaskManager.swift
//  ToDoList
//
//  Created by Татьяна on 18.02.2023.
//

import Foundation

final class OrderedTaskManager: ITaskManager {
	private let taskManager: ITaskManager
	
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}
	
	public func getTaskList() -> [Task] {
		sorted(tasks: taskManager.getTaskList())
	}
	
	public func getComletedTaskList() -> [Task] {
		sorted(tasks: taskManager.getComletedTaskList())
	}
	
	public func getNotComletedTaskList() -> [Task] {
		sorted(tasks: taskManager.getNotComletedTaskList())
	}
	
	public func addTasksToTaskList(tasks: [Task]) {
		taskManager.addTasksToTaskList(tasks: tasks)
	}
	
	private func sorted(tasks: [Task]) -> [Task] {
		tasks.sorted {
			if let taskOne = $0 as? ImportantTask, let taskTwo = $1 as? ImportantTask {
				return taskOne.priority.rawValue > taskTwo.priority.rawValue
			}
			
			if $0 is ImportantTask, $1 is RegularTask {
				return true
			}
			
			if $0 is RegularTask, $1 is ImportantTask {
				return false
			}
			return true
		}
	}
	
}
