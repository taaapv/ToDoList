//
//  ISectionForTaskManager.swift
//  ToDoList
//
//  Created by Татьяна on 18.02.2023.
//

import Foundation

protocol ISectionForTaskManager {
	func getTitleForSections() -> [String]
	func getTasksForSections(section sectionIndex: Int) -> [Task]
}

final class SectionForTaskManagerAdapter: ISectionForTaskManager {
	private let taskManager: ITaskManager
	
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}
	
	func getTitleForSections() -> [String] {
		["Not completed", "Completed"]
	}
	
	func getTasksForSections(section sectionIndex: Int) -> [Task] {
		switch sectionIndex {
		case 0 :
			return taskManager.getNotComletedTaskList()
		default:
			return taskManager.getComletedTaskList()
		}
	}
	
	
}
