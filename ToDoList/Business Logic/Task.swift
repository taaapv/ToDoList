//
//  Task.swift
//  ToDoList
//
//  Created by Татьяна on 11.02.2023.
//

import Foundation

/// class model Task
class Task {
	/// title of task
	var title: String
	
	/// completed or not task
	var completed = false
	
	/// Initialization of task
	/// - Parameters:
	///   - completed: is that task complete or not
	///   - title: title of task
	init(completed: Bool = false, title: String) {
		self.completed = completed
		self.title = title
	}
}

/// Child class Regular Task from parent class Task
final class RegularTask: Task {}

/// Child class Important Task from parent class Task
final class ImportantTask: Task {
	
	/// Enum priority of tasks
	enum Priority: Int {
		case low = 3
		case medium = 2
		case high = 1
	}
	
	/// Constant priority of task
	let priority: Priority
	
	/// Variable date Of Completion of task
	var dateOfCompletion: Date? {
		return Calendar.current.date(byAdding: .day, value: priority.rawValue, to: Date())
	}
	
	/// Initialization class Important Task
	/// - Parameters:
	///   - completed: completed or not of task
	///   - title: title of task
	///   - priority: priority of task
	init(completed: Bool = false, title: String, priority: Priority) {
		self.priority = priority
		super.init(title: title)
	}
}

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
