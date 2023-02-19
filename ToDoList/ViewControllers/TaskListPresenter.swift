//
//  ITaskListPresenter.swift
//  ToDoList
//
//  Created by Татьяна on 18.02.2023.
//

import Foundation

/// Protocol Task List Presenter
protocol ITaskListPresenter {
	func viewLoaded()
	func cellTapped(indexPath: IndexPath)
}

/// Task List Presenter with business logic
final class TaskListPresenter: ITaskListPresenter {
	
	/// class TaskListViewController
	unowned let view: ITaskListViewController!
	
	private var sectionForTaskManager: ISectionForTaskManager!
	private var viewData: ViewData!
	
	/// Initilialization TaskListViewController with protocol
	/// - Parameter view: protocol TaskListViewController
	init(view: ITaskListViewController) {
		self.view = view
		setup()
	}
	
	/// View of main view controller did load
	func viewLoaded() {
		// Не знаю как передать сюда index Path, причем в каждой функции он должен быть свой

		let numberOfSection = getCountOfSections()
		let titlesForHeaderInSection = getTitlesForHeaderInSection()
		let tasksInSections = getTasksForSections(indexPath: indexPath)
		let contentText = getContentTextForRow(indexPath: indexPath)
		let contentSecondaryText = getContentSecondaryTextForRow(indexPath: indexPath)
		let cellBackgroundColor = getColorForRow(indexPath: indexPath)
		let cellAccessoryType = getAccessoryTypeForRow(indexPath: indexPath)
		
		let viewData = ViewData(
			numberOfSection: numberOfSection,
			titlesForHeaderInSection: titlesForHeaderInSection,
			tasksInSections: tasksInSections,
			contentText: contentText,
			contentSecondaryText: contentSecondaryText,
			cellBackgroundColor: cellBackgroundColor,
			cellAccessoryType: cellAccessoryType
		)
		
		self.viewData = viewData
		view.render(viewData: viewData)
	}
	
	/// Toggle completed of task
	/// - Parameter indexPath: index of section
	func cellTapped(indexPath: IndexPath) {
		let currentTask = sectionForTaskManager.getTasksForSections(section: indexPath.section)[indexPath.row]
		currentTask.completed.toggle()
	}
	
	private func getCountOfSections() -> Int {
		sectionForTaskManager.getTitleForSections().count
	}
	
	private func getTitlesForHeaderInSection() -> [String] {
		sectionForTaskManager.getTitleForSections()
	}
	
	private func getTasksForSections(indexPath: IndexPath) -> [Task] {
		sectionForTaskManager.getTasksForSections(section: indexPath.section)
	}
	
	private func getContentTextForRow(indexPath: IndexPath) -> String {
		let currentTask = sectionForTaskManager.getTasksForSections(section: indexPath.section)[indexPath.row]
		
		switch currentTask {
		case is RegularTask:
			return currentTask.title
		case is ImportantTask:
			let task = currentTask as! ImportantTask
			return task.priority.description + " " + task.title
		default:
			return ""
		}
	}
	
	private func getContentSecondaryTextForRow(indexPath: IndexPath) -> String? {
		let currentTask = sectionForTaskManager.getTasksForSections(section: indexPath.section)[indexPath.row]
		
		if currentTask is ImportantTask {
			let task = currentTask as! ImportantTask
			return "Deadline: " + (task.dateOfCompletion?.formatted() ?? "unknown date")
		} else {
			return nil
		}
	}
	
	// Надо заменить UIColor, пока не знаю как
	private func getColorForRow(indexPath: IndexPath) -> UIColor? {
		let currentTask = sectionForTaskManager.getTasksForSections(section: indexPath.section)[indexPath.row]
		
		if currentTask is ImportantTask {
			let task = currentTask as! ImportantTask
			if let dateOfCompletion = task.dateOfCompletion, dateOfCompletion < Date() {
				return .systemPink
			} else {
				return nil
			}
		} else {
			return nil
		}
	}
	
	// Надо заменить UITableViewCell.AccessoryType, пока не знаю как
	private func getAccessoryTypeForRow(indexPath: IndexPath) -> UITableViewCell.AccessoryType {
		let currentTask = sectionForTaskManager.getTasksForSections(section: indexPath.section)[indexPath.row]
		
		return currentTask.completed ? .checkmark : .none
	}
	
	private func setup() {
		let taskManager: ITaskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: ITaskRepository = TaskRepositoryStub()
		taskManager.addTasksToTaskList(tasks: repository.createTasks())
		sectionForTaskManager = SectionForTaskManagerAdapter(taskManager: taskManager)
	}
}
