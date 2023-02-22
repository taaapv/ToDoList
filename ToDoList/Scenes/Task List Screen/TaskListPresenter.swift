//
//  ITaskListPresenter.swift
//  ToDoList
//
//  Created by Татьяна on 18.02.2023.
//

import Foundation

protocol TaskListDataStore {
	var email: String? { get set }
	var password: String? { get set }
}

/// Protocol Task List Presenter
protocol ITaskListPresenter {
	func viewLoaded()
	func cellTapped(at indexPath: IndexPath)
}

/// Task List Presenter with business logic
final class TaskListPresenter: ITaskListPresenter, TaskListDataStore {
	var email: String?
	var password: String?
	
	private weak var view: ITaskListViewController!
	private var sectionManager: ISectionForTaskManagerAdapter!
	
	/// Initilialization TaskListViewController with protocol
	/// - Parameter view: protocol TaskListViewController
	init(view: ITaskListViewController, sectionManager: ISectionForTaskManagerAdapter) {
		self.view = view
		self.sectionManager = sectionManager
	}
	
	/// View of main view controller did load
	func viewLoaded() {
		view?.render(viewData: mapViewData())
	}
	
	/// Toggle completed of task
	/// - Parameter indexPath: index of section
	func cellTapped(at indexPath: IndexPath) {
		let section = sectionManager.getSectionForIndex(index: indexPath.section)
		let task = sectionManager.getTasksForSection(section: section)[indexPath.row]
		task.completed.toggle()
		view.render(viewData: mapViewData())
	}
	
	private func mapViewData() -> TaskListViewModel.ViewData {
		var sections = [TaskListViewModel.ViewData.Section]()
		for section in sectionManager.getSections() {
			let sectionData = TaskListViewModel.ViewData.Section(
				title: section.title,
				tasks: mapTasksData(tasks: sectionManager.getTasksForSection(section: section))
			)
			sections.append(sectionData)
		}
		return TaskListViewModel.ViewData(tasksSortedBySection: sections)
	}
	
	private func mapTasksData(tasks: [Task]) -> [TaskListViewModel.ViewData.Task] {
		tasks.map { mapTaskData(task: $0) }
	}
	
	private func mapTaskData(task: Task) -> TaskListViewModel.ViewData.Task {
		if let task = task as? ImportantTask {
			let result = TaskListViewModel.ViewData.ImportantTask(
				name: task.title,
				isDone: task.completed,
				isOverdue: task.dateOfCompletion! < Date(),
				deadline: "Deadline: \(String(describing: task.dateOfCompletion))",
				priority: "\(task.priority)"
			)
			return .importantTask(result)
		} else {
			return .regularTask(TaskListViewModel.ViewData.RegularTask(name: task.title, isDone: task.completed))
		}
	}
}
