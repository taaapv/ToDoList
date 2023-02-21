//
//  ISectionForTaskManager.swift
//  ToDoList
//
//  Created by Татьяна on 18.02.2023.
//

import Foundation

/// Protocol about sections from Task Manager
protocol ISectionForTaskManagerAdapter {
	func getSections() -> [SectionOfTasks]
	func getSectionIndex(section: SectionOfTasks) -> Int
	func getSectionForIndex(index: Int) -> SectionOfTasks
	func getTasksForSection(section: SectionOfTasks) -> [Task] 
	func getSectionAndIndexFromTask(task: Task) -> (section: SectionOfTasks, index: Int)?
}

enum SectionOfTasks: CaseIterable {
	case completed
	case notCompleted
	
	var title: String {
		switch self {
		case .completed:
			return "Completed"
		case .notCompleted:
			return "Not completed"
		}
	}
}

/// Class sections from Task Manager
final class SectionForTaskManagerAdapter: ISectionForTaskManagerAdapter {
	private let taskManager: ITaskManager
	private let sectionsOfTasks: [SectionOfTasks] = SectionOfTasks.allCases
	
	/// Initialization Task Manager
	/// - Parameter taskManager: protocol Task Manager
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}
	
	/// get Sections
	/// - Returns: Sections Of Tasks
	func getSections() -> [SectionOfTasks] {
		sectionsOfTasks
	}
	
	/// get Section Index from section
	/// - Parameter section: Section Of Tasks
	/// - Returns: Section Index
	func getSectionIndex(section: SectionOfTasks) -> Int {
		sectionsOfTasks.firstIndex(of: section) ?? 0
	}
	
	/// get Section for index
	/// - Parameter index: index of section
	/// - Returns: Section Of Tasks
	func getSectionForIndex(index: Int) -> SectionOfTasks {
		let i = min(index, sectionsOfTasks.count - 1)
		return sectionsOfTasks[i]
	}
	
	/// get Tasks For Section
	/// - Parameter section: Section Of Tasks
	/// - Returns: Task list
	func getTasksForSection(section: SectionOfTasks) -> [Task] {
		switch section {
		case .completed:
			return taskManager.getComletedTaskList()
		case .notCompleted:
			return taskManager.getNotComletedTaskList()
		}
	}
	
	/// get Section And Index of task From Task
	/// - Parameter task: task of class Task
	/// - Returns: Section And Index of task
	func getSectionAndIndexFromTask(task: Task) -> (section: SectionOfTasks, index: Int)? {
		for sectionsOfTask in sectionsOfTasks {
			let index = getTasksForSection(section: sectionsOfTask).firstIndex { task === $0 }
			if index != nil {
				return (sectionsOfTask, index!)
			}
		}
		return nil
	}
}
