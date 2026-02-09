//
//  HomeViewModel.swift
//  SOLARA
//
//  Created by Andreas Pelczer on 09.02.26.
//

import Foundation
import Observation
import SwiftUI

@Observable
final class HomeViewModel {
    var store = TaskStore()
    var popups = PopUpPresenter()

    var newTaskTitle: String = ""

    // Animation states
    var glowingTaskID: UUID?
    var shakingTaskID: UUID?
    var dangerFlashTaskID: UUID?
    var completingTaskID: UUID?
    var newlyAddedTaskID: UUID?
    var titleAppeared = false

    func onAppear() {
        // Midnight easter egg
        let hour = Calendar.current.component(.hour, from: Date())
        if hour == 0 {
            popups.show(message: SolaraPhrases.midnightMessage)
        } else {
            popups.maybeShow(trigger: .appLaunch)
        }

        // Animate title
        withAnimation(.easeOut(duration: 0.6).delay(0.2)) {
            titleAppeared = true
        }
    }

    func addTask() {
        let trimmed = newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        // Easter egg check
        let lowered = trimmed.lowercased()
        if let easterEgg = SolaraPhrases.easterEggs[lowered] {
            store.add(title: trimmed)
            let addedID = store.tasks.first?.id
            newTaskTitle = ""
            if let id = addedID {
                newlyAddedTaskID = id
                clearAnimation(\.newlyAddedTaskID, after: 0.4)
            }
            popups.show(message: easterEgg)
            return
        }

        store.add(title: trimmed)
        let addedID = store.tasks.first?.id
        newTaskTitle = ""

        if let id = addedID {
            newlyAddedTaskID = id
            clearAnimation(\.newlyAddedTaskID, after: 0.4)
        }

        // 100 tasks easter egg
        if store.tasks.count >= 100 {
            popups.show(message: SolaraPhrases.tooManyTasksMessage)
        } else {
            popups.maybeShow(trigger: .taskAdded)
        }
    }

    func attemptComplete(_ task: TaskItem) {
        let roll = Int.random(in: 1...100)
        if roll <= 30 {
            // Hard no - increment counter
            store.incrementNoCount(task)

            let updatedTask = store.tasks.first { $0.id == task.id }
            let noCount = updatedTask?.consecutiveNoCount ?? 1

            // Shake animation
            shakingTaskID = task.id
            dangerFlashTaskID = task.id

            withAnimation(.default.repeatCount(3, autoreverses: true).speed(4)) {
                shakingTaskID = task.id
            }

            clearAnimation(\.shakingTaskID, after: 0.4)
            clearAnimation(\.dangerFlashTaskID, after: 0.4)

            // 5 consecutive no's easter egg
            if noCount >= 5 {
                popups.show(message: SolaraPhrases.consecutiveNoMessage)
                store.resetNoCount(task)
            } else {
                popups.maybeShow(trigger: .hardNo)
            }
        } else {
            // Success - slide out animation
            completingTaskID = task.id

            // Trigger haptic and popup before removal
            popups.maybeShow(trigger: .taskCompleted)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                guard let self else { return }
                self.store.remove(task)
                self.completingTaskID = nil
            }
        }
    }

    func deleteTask(_ task: TaskItem) {
        store.remove(task)
        popups.maybeShow(trigger: .taskDeleted)
    }

    func tapped(_ task: TaskItem) {
        store.shuffleState(task)

        // Gold glow
        glowingTaskID = task.id
        clearAnimation(\.glowingTaskID, after: 0.3)

        popups.maybeShow(trigger: .taskTapped)
    }

    private func clearAnimation(_ keyPath: ReferenceWritableKeyPath<HomeViewModel, UUID?>, after delay: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?[keyPath: keyPath] = nil
        }
    }
}
