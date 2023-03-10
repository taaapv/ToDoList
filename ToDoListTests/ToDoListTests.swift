//
//  ToDoListTests.swift
//  ToDoListTests
//
//  Created by Татьяна on 10.03.2023.
//

import XCTest
@testable import ToDoList

class StubTaskManager: ITaskManager {
	var tasks: [Task] = []
	
	func getTaskList() -> [Task] {
		self.tasks
	}
	
	func getComletedTaskList() -> [Task] {
		self.tasks.filter { $0.completed }
	}
	
	func getNotComletedTaskList() -> [Task] {
		self.tasks.filter { !$0.completed }
	}
	
	func addTasksToTaskList(tasks: [Task]) {
		self.tasks.append(contentsOf: tasks)
	}
}

class ToDoListTests: XCTestCase {
	
	var sut: StubTaskManager!
	var tasks: [Task]!
	var tasksToAdd: [Task]!
	
	override func setUp() {
		sut = StubTaskManager()
		
		tasks = [
			Task(
				completed: true,
				title: "Task 1"
			),
			Task(
				completed: false,
				title: "Task 2"
			)
		]
		sut.tasks = tasks
		
		tasksToAdd = [
			Task(
				completed: false,
				title: "Task 3"
			)
		]
	}
	override func tearDown() {
		sut = nil
		tasks = nil
	}
	
	func test_taskManager_getTaskList() {
		XCTAssertEqual(
			sut.getTaskList(),
			[
				Task(
					completed: true,
					title: "Task 1"
				),
				Task(
					completed: false,
					title: "Task 2"
				)
			]
		)
	}
	
	func test_taskManager_getComletedTaskList() {
		XCTAssertEqual(
			sut.getComletedTaskList(),
			[
				Task(
					completed: true,
					title: "Task 1"
				)
			]
		)
	}
	
	func test_taskManager_getNotComletedTaskList() {
		XCTAssertEqual(
			sut.getNotComletedTaskList(),
			[
				Task(
					completed: false,
					title: "Task 2"
				)
			]
		)
	}
	
	func test_taskManager_addTasksToTaskList() {
		sut.addTasksToTaskList(tasks: tasksToAdd)
		XCTAssertEqual(
			tasksToAdd,
			[Task(
				completed: false,
				title: "Task 3"
			)]
		)
	}
}
