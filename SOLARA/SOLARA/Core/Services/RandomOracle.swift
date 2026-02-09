//
//  RandomOracle.swift
//  SOLARA
//
//  Created by Andreas Pelczer on 09.02.26.
//

import Foundation

struct RandomOracle {
    func randomPopup() -> String {
        SolaraPhrases.popups.randomElement() ?? "Ich fühle: Es ist… irgendwas."
    }

    func hardNo() -> String {
        SolaraPhrases.hardNoReasons.randomElement() ?? "Nein."
    }

    func message(for trigger: PopUpPresenter.Trigger) -> String {
        switch trigger {
        case .appLaunch:
            return SolaraPhrases.appLaunchMessages.randomElement() ?? randomPopup()
        case .taskAdded:
            return SolaraPhrases.taskAddedMessages.randomElement() ?? randomPopup()
        case .taskTapped:
            return SolaraPhrases.taskTappedMessages.randomElement() ?? randomPopup()
        case .taskCompleted:
            return SolaraPhrases.taskCompletedMessages.randomElement() ?? randomPopup()
        case .taskDeleted:
            return SolaraPhrases.taskDeletedMessages.randomElement() ?? randomPopup()
        case .hardNo:
            return hardNo()
        case .easterEgg:
            return randomPopup()
        }
    }
}
