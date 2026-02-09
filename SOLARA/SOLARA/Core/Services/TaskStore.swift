//
//  TaskStore.swift
//  SOLARA
//
//  Created by Andreas Pelczer on 09.02.26.
//


import Foundation
import Observation

@Observable
final class TaskStore {
    private(set) var tasks: [TaskItem] = []

    func add(title: String) {
        let t = TaskItem(title: title, cosmicState: .allCases.randomElement() ?? .blockiert)
        tasks.insert(t, at: 0)
    }

    func remove(_ task: TaskItem) {
        tasks.removeAll { $0.id == task.id }
    }

    func shuffleState(_ task: TaskItem) {
        guard let idx = tasks.firstIndex(of: task) else { return }
        tasks[idx].cosmicState = TaskItem.CosmicState.allCases.randomElement() ?? .blockiert
    }
}
