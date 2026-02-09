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

    /// Satire-Regel: Popup kommt selten genug, dass es „besonders“ wirkt.
    func maybeShow(trigger: Trigger) {
        // simple Wahrscheinlichkeit je Trigger
        let chance: Int
        switch trigger {
        case .appLaunch: chance = 35
        case .taskAdded: chance = 25
        case .taskTapped: chance = 18
        case .hardNo: chance = 100
        }

        let roll = Int.random(in: 1...100)
        guard roll <= chance else { return }

        if trigger == .hardNo {
            message = oracle.hardNo()
        } else {
            message = oracle.randomPopup()
        }
        isShowing = true
    }

    func dismiss() { isShowing = false }

    enum Trigger {
        case appLaunch
        case taskAdded
        case taskTapped
        case hardNo
    }
}
