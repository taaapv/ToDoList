//
//  TaskManager.swift
//  ToDoList
//
//  Created by Татьяна on 11.02.2023.
//

import Foundation

/// Сlass providing work with tasks
final class TaskManager {
	private var taskList: [Task] = []
	
	
	/// Get task list
	/// - Returns: Task List
	public func getTaskList() -> [Task] {
		taskList
	}
	
	/// Get Comleted Task List
	/// - Returns: Comleted Task List
	public func getComletedTaskList() -> [Task] {
		taskList.filter { $0.completed }
	}
	
	/// Get Not Comleted Task List
	/// - Returns: Not Comleted Task List
	public func getNotComletedTaskList() -> [Task] {
		taskList.filter { !$0.completed }
	}
	
	/// Add new Task To the Task List
	/// - Parameter newTask: new Task
	public func addTaskToTaskList(newTask: Task) {
		taskList.append(newTask)
	}
	
	/// Add new Tasks To the Task List
	/// - Parameter tasks: new Tasks
	public func addTasksToTaskList(tasks: [Task]) {
		taskList.append(contentsOf: tasks)
	}
	
	/// Delete Task From Task List
	/// - Parameter task: deleted task
	public func removeTaskFromTaskList(task: Task) {
		taskList.removeAll { $0 === task }
	}
}
