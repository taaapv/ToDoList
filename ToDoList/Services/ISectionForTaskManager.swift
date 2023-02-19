//
//  ISectionForTaskManager.swift
//  ToDoList
//
//  Created by Татьяна on 18.02.2023.
//

import Foundation

/// Protocol about sections from Task Manager
protocol ISectionForTaskManager {
	func getTitleForSections() -> [String]
	func getTasksForSections(section sectionIndex: Int) -> [Task]
}

/// Class sections from Task Manager
final class SectionForTaskManagerAdapter: ISectionForTaskManager {
	private let taskManager: ITaskManager
	
	/// Initialization Task Manager
	/// - Parameter taskManager: protocol Task Manager
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}
	
	/// Get Title For Sections
	/// - Returns: Titles For Sections
	func getTitleForSections() -> [String] {
		["Not completed", "Completed"]
	}
	
	/// Get Tasks For Sections
	/// - Parameter sectionIndex: index of section
	/// - Returns: tasks to current section
	func getTasksForSections(section sectionIndex: Int) -> [Task] {
		switch sectionIndex {
		case 0 :
			return taskManager.getNotComletedTaskList()
		default:
			return taskManager.getComletedTaskList()
		}
	}
	
	
}
