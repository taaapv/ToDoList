//
//  ITaskListPresenter.swift
//  ToDoList
//
//  Created by Татьяна on 18.02.2023.
//

import Foundation

protocol ITaskListPresenter {
	func presentViewData(sectionManager: ISectionForTaskManagerAdapter)
}

final class TaskListPresenter: ITaskListPresenter {

	
	private weak var view: ITaskListViewController?
	
	init(view: ITaskListViewController) {
		self.view = view
	}
	
	func presentViewData(sectionManager: ISectionForTaskManagerAdapter) {
		let viewData = mapViewData(sectionManager: sectionManager)
		view?.render(viewData: viewData)
	}
	
	private func mapViewData(sectionManager: ISectionForTaskManagerAdapter) -> TaskListViewModel.ViewData {
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
