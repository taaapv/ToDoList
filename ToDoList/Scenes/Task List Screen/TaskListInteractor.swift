//
//  TaskListInteractor.swift
//  ToDoList
//
//  Created by Татьяна on 03.03.2023.
//

import Foundation

protocol TaskListDataStore {
	var email: String? { get set }
	var password: String? { get set }
}

protocol ITaskListInteractor {
	func viewLoaded()
	func taskSelected(at indexPath: IndexPath)
}

final class TaskListInteractor: ITaskListInteractor, TaskListDataStore {
	var email: String?
	var password: String?
	
	private var worker: ITaskListWorker
	private var presenter: ITaskListPresenter?
	private var sectionManager: ISectionForTaskManagerAdapter!
	private var taskManager: ITaskManager!
	
	init(worker: ITaskListWorker, presenter: ITaskListPresenter) {
		self.worker = worker
		self.presenter = presenter
	}
	
	func viewLoaded() {
		setupTaskManager()
		presentViewData()
		
	}
	
	func taskSelected(at indexPath: IndexPath) {
		let section = sectionManager.getSectionForIndex(index: indexPath.section)
		let task = sectionManager.getTasksForSection(section: section)[indexPath.row]
		task.completed.toggle()
		presentViewData()
	}
	
	private func setupTaskManager() {
		taskManager = OrderedTaskManager(taskManager: TaskManager())
		let tasks = worker.createTasks()
		taskManager.addTasksToTaskList(tasks: tasks)
	}
	
	private func presentViewData() {
		sectionManager = SectionForTaskManagerAdapter(taskManager: taskManager)
		let viewData = mapViewData()
		presenter?.presentViewData(viewData: viewData)
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
