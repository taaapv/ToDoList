//
//  ITaskListPresenter.swift
//  ToDoList
//
//  Created by Татьяна on 18.02.2023.
//

import Foundation

protocol ITaskListPresenter {
	func present(response: TaskListModels.Response)
}

final class TaskListPresenter: ITaskListPresenter {

	private weak var viewController: ITaskListViewController?
	
	init(viewController: ITaskListViewController) {
		self.viewController = viewController
	}
	
	func present(response: TaskListModels.Response) {
		var sections = [TaskListModels.ViewModel.Section]()
		for section in response.data {
			let sectionData = TaskListModels.ViewModel.Section(
				title: section.section.title,
				tasks: mapTasksData(tasks: section.tasks)
			)
			sections.append(sectionData)
		}
		let viewModel = TaskListModels.ViewModel(tasksSortedBySections: sections)
		viewController?.render(viewModel: viewModel)
	}
	
	private func mapTasksData(tasks: [Task]) -> [TaskListModels.ViewModel.Task] {
		tasks.map { mapTaskData(task: $0) }
	}
	
	private func mapTaskData(task: Task) -> TaskListModels.ViewModel.Task {
		if let task = task as? ImportantTask {
			let result = TaskListModels.ViewModel.ImportantTask(
				name: task.title,
				isDone: task.completed,
				isOverdue: task.dateOfCompletion! < Date(),
				deadline: "Deadline: \(String(describing: task.dateOfCompletion))",
				priority: "\(task.priority)"
			)
			return .importantTask(result)
		} else {
			return .regularTask(TaskListModels.ViewModel.RegularTask(
				name: task.title,
				isDone: task.completed)
			)
		}
	}
}
