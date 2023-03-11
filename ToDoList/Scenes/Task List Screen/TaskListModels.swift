//
//  TaskListViewModel.swift
//  ToDoList
//
//  Created by Татьяна on 21.02.2023.
//

import Foundation

enum TaskListModels {
	enum Request {
		struct TaskSelected {
			let indexPath: IndexPath
		}
	}
	
	struct Response {
		struct SectionWithTasks {
			let section: Section
			let tasks: [Task]
		}
		let data: [SectionWithTasks]
	}
	
	struct ViewModel {
		struct RegularTask {
			let name: String
			let isDone: Bool
		}
		
		struct ImportantTask {
			let name: String
			let isDone: Bool
			let isOverdue: Bool
			let deadline: String
			let priority: String
		}
		
		enum Task {
			case regularTask(RegularTask)
			case importantTask(ImportantTask)
		}
		
		struct Section {
			let title: String
			let tasks: [Task]
		}
		
		let tasksSortedBySections: [Section]
	}
}
