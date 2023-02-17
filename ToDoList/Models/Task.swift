//
//  Task.swift
//  ToDoList
//
//  Created by Татьяна on 11.02.2023.
//

import Foundation

class Task {
	var completed = false
	var title: String
	
	init(completed: Bool = false, title: String) {
		self.completed = completed
		self.title = title
	}
}

final class RegularTask: Task {}

final class ImportantTask: Task {
	enum Priority: Int {
		case low = 3
		case medium = 2
		case high = 1
	}
	
	let priority: Priority
	
	var dateOfCompletion: Date? {
		return Calendar.current.date(byAdding: .day, value: priority.rawValue, to: Date())
	}
	
	init(completed: Bool = false, title: String, priority: Priority) {
		self.priority = priority
		super.init(title: title)
	}
}
