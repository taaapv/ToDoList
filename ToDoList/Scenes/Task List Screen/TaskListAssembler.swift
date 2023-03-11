//
//  TaskListAssembler.swift
//  ToDoList
//
//  Created by Татьяна on 12.03.2023.
//

import UIKit

final class TaskListAssembler {
	func assembly() -> UIViewController {
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		guard let taskListViewController = storyboard.instantiateViewController(withIdentifier: "TaskListViewController") as? TaskListViewController else {
			fatalError("TaskListViewController not exist in Main.storyboard")
		}
		let taskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: ITaskRepository = TaskRepositoryStub()
		taskManager.addTasksToTaskList(tasks: repository.createTasks())
		let sectionManager = SectionForTaskManagerAdapter(taskManager: taskManager)
		
		let presenter = TaskListPresenter(viewController: taskListViewController)
		let interactor = TaskListInteractor(presenter: presenter, sectionManager: sectionManager)
		taskListViewController.interactor = interactor
		
		
		return taskListViewController
	}
}
