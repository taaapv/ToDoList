//
//  SceneDelegate.swift
//  ToDoList
//
//  Created by Татьяна on 11.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)
		
		window.rootViewController = assembly()
		window.makeKeyAndVisible()
		
		self.window = window
	}
	
	private func assembly() -> UIViewController {
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		
		guard let taskListViewController = storyboard.instantiateViewController(withIdentifier: "TaskListViewController") as? TaskListViewController else {
			fatalError("TaskListViewController not exist in Main.storyboard")
		}
		
		let taskManager: ITaskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: ITaskRepository = TaskRepositoryStub()
		taskManager.addTasksToTaskList(tasks: repository.createTasks())
		let sectionManager = SectionForTaskManagerAdapter(taskManager: taskManager)
		let taskListPresenter = TaskListPresenter(view: taskListViewController, sectionManager: sectionManager)
		taskListViewController.presenter = taskListPresenter
		
		return taskListViewController
	}
}

