//
//  TaskListInteractor.swift
//  ToDoList
//
//  Created by Татьяна on 03.03.2023.
//

import Foundation
protocol ITaskListInteractor {
	func viewLoaded()
	func taskSelected(at indexPath: IndexPath)
}

final class TaskListInteractor: ITaskListInteractor {

	private var presenter: ITaskListPresenter?
	private var sectionManager: ISectionForTaskManagerAdapter
	
	init(presenter: ITaskListPresenter, sectionManager: ISectionForTaskManagerAdapter) {
		self.presenter = presenter
		self.sectionManager = sectionManager
	}
	
	func viewLoaded() {
		var responseData = [TaskListModels.Response.SectionWithTasks]()
		let sections = sectionManager.getSections()
		for section in sections {
			let tasks = sectionManager.getTasksForSection(section: section)
			let sectionWithTasks = TaskListModels.Response.SectionWithTasks(
				section: section,
				tasks: tasks
			)
			responseData.append(sectionWithTasks)
		}
		let response = TaskListModels.Response(data: responseData)
		presenter?.present(response: response)
	}
	
	func taskSelected(at indexPath: IndexPath) {
		let section = sectionManager.getSectionForIndex(index: indexPath.section)
		let task = sectionManager.getTasksForSection(section: section)[indexPath.row]
		task.completed.toggle()
		viewLoaded()
	}
}
