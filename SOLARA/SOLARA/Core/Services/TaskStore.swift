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
    private static let storageKey = "solara.tasks"

    private(set) var tasks: [TaskItem] = []

    init() {
        load()
    }

    func add(title: String) {
        let t = TaskItem(title: title, cosmicState: .allCases.randomElement() ?? .blockiert)
        tasks.insert(t, at: 0)
        save()
    }

    func remove(_ task: TaskItem) {
        tasks.removeAll { $0.id == task.id }
        save()
    }

    func shuffleState(_ task: TaskItem) {
        guard let idx = tasks.firstIndex(of: task) else { return }
        tasks[idx].cosmicState = TaskItem.CosmicState.allCases.randomElement() ?? .blockiert
        save()
    }

    func incrementNoCount(_ task: TaskItem) {
        guard let idx = tasks.firstIndex(of: task) else { return }
        tasks[idx].consecutiveNoCount += 1
        save()
    }

    func resetNoCount(_ task: TaskItem) {
        guard let idx = tasks.firstIndex(of: task) else { return }
        tasks[idx].consecutiveNoCount = 0
        save()
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(tasks) else { return }
        UserDefaults.standard.set(data, forKey: Self.storageKey)
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: Self.storageKey),
              let decoded = try? JSONDecoder().decode([TaskItem].self, from: data) else { return }
        tasks = decoded
    }
}
