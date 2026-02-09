//
//  HomeViewModel.swift
//  SOLARA
//
//  Created by Andreas Pelczer on 09.02.26.
//


import Foundation
import Observation

@Observable
final class HomeViewModel {
    var store = TaskStore()
    var popups = PopUpPresenter()

    var newTaskTitle: String = ""

    func onAppear() {
        popups.maybeShow(trigger: .appLaunch)
    }

    func addTask() {
        let trimmed = newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        store.add(title: trimmed)
        newTaskTitle = ""
        popups.maybeShow(trigger: .taskAdded)
    }

    /// Satire: statt „Done“ gibt’s manchmal ein hartes Nein.
    func attemptComplete(_ task: TaskItem) {
        let roll = Int.random(in: 1...100)
        if roll <= 30 {
            popups.maybeShow(trigger: .hardNo)
        } else {
            store.remove(task)
        }
    }

    func tapped(_ task: TaskItem) {
        store.shuffleState(task)
        popups.maybeShow(trigger: .taskTapped)
    }
}
