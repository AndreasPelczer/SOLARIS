//
//  PopUpPresenter.swift
//  SOLARA
//
//  Created by Andreas Pelczer on 09.02.26.
//

import Foundation
import Observation

@Observable
final class PopUpPresenter {
    var isShowing: Bool = false
    var message: String = ""

    private let oracle = RandomOracle()

    enum Trigger {
        case appLaunch       // 35%
        case taskAdded       // 25%
        case taskTapped      // 18%
        case taskCompleted   // 40%
        case taskDeleted     // 20%
        case hardNo          // 100%
        case easterEgg       // 100%
    }

    func maybeShow(trigger: Trigger) {
        let chance: Int
        switch trigger {
        case .appLaunch:     chance = 35
        case .taskAdded:     chance = 25
        case .taskTapped:    chance = 18
        case .taskCompleted: chance = 40
        case .taskDeleted:   chance = 20
        case .hardNo:        chance = 100
        case .easterEgg:     chance = 100
        }

        let roll = Int.random(in: 1...100)
        guard roll <= chance else { return }

        message = oracle.message(for: trigger)
        isShowing = true
    }

    func show(message: String) {
        self.message = message
        isShowing = true
    }

    func dismiss() { isShowing = false }
}
