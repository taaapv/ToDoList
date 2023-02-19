//
//  OrderedTaskManager.swift
//  ToDoList
//
//  Created by Татьяна on 18.02.2023.
//

import Foundation

/// Decorator class to class Task Manager, sorting tasks in order of priority
final class OrderedTaskManager: ITaskManager {
	private let taskManager: ITaskManager
	
	/// Initialization Task Manager
	/// - Parameter taskManager: protocol Task Manager
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}
	
	/// Get ordered Task List
	/// - Returns: ordered Task List
	public func getTaskList() -> [Task] {
		sorted(tasks: taskManager.getTaskList())
	}
	
	/// Get ordered Comleted Task List
	/// - Returns: ordered Comleted Task List
	public func getComletedTaskList() -> [Task] {
		sorted(tasks: taskManager.getComletedTaskList())
	}
	
	/// Get ordered Not Comleted Task List
	/// - Returns: ordered Not Comleted Task List
	public func getNotComletedTaskList() -> [Task] {
		sorted(tasks: taskManager.getNotComletedTaskList())
	}
	
	/// Add new Tasks To Task List
	/// - Parameter tasks: new Tasks
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
