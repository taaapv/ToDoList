//
//  TaskManager.swift
//  ToDoList
//
//  Created by Татьяна on 11.02.2023.
//

import Foundation

final class TaskManager {
	private var taskList: [Task] = []
	
	public func getTaskList() -> [Task] {
		taskList
	}
	
	public func getComletedTaskList() -> [Task] {
		taskList.filter { $0.completed }
	}
	
	public func getNotComletedTaskList() -> [Task] {
		taskList.filter { !$0.completed }
	}
	
	public func addTaskToTaskList(newTask: Task) {
		taskList.append(newTask)
	}
	
	public func addTasksToTaskList(tasks: [Task]) {
		taskList.append(contentsOf: tasks)
	}
	
	public func removeTaskFromTaskList(task: Task) {
		taskList.removeAll { $0 === task }
	}
}
