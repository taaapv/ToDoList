//
//  ISectionForTaskManager.swift
//  ToDoList
//
//  Created by Татьяна on 18.02.2023.
//

import Foundation

/// Protocol about sections from Task Manager
protocol ISectionForTaskManagerAdapter {
	func getSections() -> [Section]
	func getSectionIndex(section: Section) -> Int
	func getSectionForIndex(index: Int) -> Section
	func getTasksForSection(section: Section) -> [Task] 
	func getSectionAndIndexFromTask(task: Task) -> (section: Section, index: Int)?
}

enum Section: CaseIterable {
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
	private let sectionsOfTasks: [Section] = Section.allCases
	
	/// Initialization Task Manager
	/// - Parameter taskManager: protocol Task Manager
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}
	
	/// get Sections
	/// - Returns: Sections Of Tasks
	func getSections() -> [Section] {
		sectionsOfTasks
	}
	
	/// get Index from section
	/// - Parameter section: Section Of Tasks
	/// - Returns: Section Index
	func getSectionIndex(section: Section) -> Int {
		sectionsOfTasks.firstIndex(of: section) ?? 0
	}
	
	/// get Section for index
	/// - Parameter index: index of section
	/// - Returns: Section Of Tasks
	func getSectionForIndex(index: Int) -> Section {
		let i = min(index, sectionsOfTasks.count - 1)
		return sectionsOfTasks[i]
	}
	
	/// get Tasks For Section
	/// - Parameter section: Section Of Tasks
	/// - Returns: Task list
	func getTasksForSection(section: Section) -> [Task] {
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
	func getSectionAndIndexFromTask(task: Task) -> (section: Section, index: Int)? {
		for sectionsOfTask in sectionsOfTasks {
			let index = getTasksForSection(section: sectionsOfTask).firstIndex { task === $0 }
			if index != nil {
				return (sectionsOfTask, index!)
			}
		}
		return nil
	}
}
