//
//  TaskListInteractor.swift
//  ToDoList
//
//  Created by Татьяна on 03.03.2023.
//

import Foundation

protocol ITaskListDataStore {
	var email: String { get set }
	var password: String { get set }
}

protocol ITaskListInteractor {
	func viewLoaded()
	func taskSelected(at indexPath: IndexPath)
}

final class TaskListInteractor: ITaskListInteractor, ITaskListDataStore {
	var email = ""
	var password = ""
	
	
	private var presenter: ITaskListPresenter?
	private var taskManager: ITaskManager!
	private var sectionManager: ISectionForTaskManagerAdapter!
	
	
	init(worker: ITaskListWorker, presenter: ITaskListPresenter) {
		self.presenter = presenter
	}
	
	func viewLoaded() {
		taskManager = OrderedTaskManager(taskManager: TaskManager())
		addStubTasks()
		sectionManager = SectionForTaskManagerAdapter(taskManager: taskManager)
		presenter?.presentViewData(sectionManager: sectionManager)
	}
	
	func taskSelected(at indexPath: IndexPath) {
		let section = sectionManager.getSectionForIndex(index: indexPath.section)
		let task = sectionManager.getTasksForSection(section: section)[indexPath.row]
		task.completed.toggle()
		presenter?.presentViewData(sectionManager: sectionManager)
	}
	
	private func addStubTasks() {
		let repository: ITaskRepository = TaskRepositoryStub()
		let tasks = repository.createTasks()
		
		taskManager.addTasksToTaskList(tasks: tasks)
	}
}
