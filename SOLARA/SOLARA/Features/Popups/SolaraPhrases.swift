//
//  SolaraPhrases.swift
//  SOLARA
//
//  Created by Andreas Pelczer on 09.02.26.
//

import Foundation

enum SolaraPhrases {

    // MARK: - General Popups (fallback)

    static let popups: [String] = [
        String(localized: "phrases.popup.0"),
        String(localized: "phrases.popup.1"),
        String(localized: "phrases.popup.2"),
        String(localized: "phrases.popup.3"),
        String(localized: "phrases.popup.4"),
        String(localized: "phrases.popup.5"),
        String(localized: "phrases.popup.6"),
        String(localized: "phrases.popup.7"),
        String(localized: "phrases.popup.8"),
        String(localized: "phrases.popup.9")
    ]

    // MARK: - Hard No

    static let hardNoReasons: [String] = [
        String(localized: "phrases.hardno.0"),
        String(localized: "phrases.hardno.1"),
        String(localized: "phrases.hardno.2"),
        String(localized: "phrases.hardno.3"),
        String(localized: "phrases.hardno.4"),
        String(localized: "phrases.hardno.5"),
        String(localized: "phrases.hardno.6"),
        String(localized: "phrases.hardno.7"),
        String(localized: "phrases.hardno.8"),
        String(localized: "phrases.hardno.9")
    ]

    // MARK: - App Launch Messages

    static let appLaunchMessages: [String] = [
        String(localized: "phrases.launch.0"),
        String(localized: "phrases.launch.1"),
        String(localized: "phrases.launch.2"),
        String(localized: "phrases.launch.3"),
        String(localized: "phrases.launch.4"),
        String(localized: "phrases.launch.5"),
        String(localized: "phrases.launch.6"),
        String(localized: "phrases.launch.7")
    ]

    // MARK: - Task Added Messages

    static let taskAddedMessages: [String] = [
        String(localized: "phrases.added.0"),
        String(localized: "phrases.added.1"),
        String(localized: "phrases.added.2"),
        String(localized: "phrases.added.3"),
        String(localized: "phrases.added.4"),
        String(localized: "phrases.added.5"),
        String(localized: "phrases.added.6"),
        String(localized: "phrases.added.7")
    ]

    // MARK: - Task Completed Messages

    static let taskCompletedMessages: [String] = [
        String(localized: "phrases.completed.0"),
        String(localized: "phrases.completed.1"),
        String(localized: "phrases.completed.2"),
        String(localized: "phrases.completed.3"),
        String(localized: "phrases.completed.4"),
        String(localized: "phrases.completed.5"),
        String(localized: "phrases.completed.6"),
        String(localized: "phrases.completed.7")
    ]

    // MARK: - Task Deleted Messages

    static let taskDeletedMessages: [String] = [
        String(localized: "phrases.deleted.0"),
        String(localized: "phrases.deleted.1"),
        String(localized: "phrases.deleted.2"),
        String(localized: "phrases.deleted.3"),
        String(localized: "phrases.deleted.4"),
        String(localized: "phrases.deleted.5")
    ]

    // MARK: - Task Tapped Messages

    static let taskTappedMessages: [String] = [
        String(localized: "phrases.tapped.0"),
        String(localized: "phrases.tapped.1"),
        String(localized: "phrases.tapped.2"),
        String(localized: "phrases.tapped.3"),
        String(localized: "phrases.tapped.4"),
        String(localized: "phrases.tapped.5")
    ]

    // MARK: - Empty State Messages

    static let emptyStateMessages: [String] = [
        String(localized: "phrases.empty.0"),
        String(localized: "phrases.empty.1"),
        String(localized: "phrases.empty.2"),
        String(localized: "phrases.empty.3"),
        String(localized: "phrases.empty.4"),
        String(localized: "phrases.empty.5")
    ]

    // MARK: - Share Card Messages

    static let shareCardMessages: [String] = [
        String(localized: "phrases.share.0"),
        String(localized: "phrases.share.1"),
        String(localized: "phrases.share.2"),
        String(localized: "phrases.share.3"),
        String(localized: "phrases.share.4"),
        String(localized: "phrases.share.5"),
        String(localized: "phrases.share.6"),
        String(localized: "phrases.share.7")
    ]

    // MARK: - Easter Eggs

    static let easterEggs: [String: String] = [
        String(localized: "easter.key.meditate"): String(localized: "easter.val.meditate"),
        String(localized: "easter.key.enlightenment"): String(localized: "easter.val.enlightenment"),
        String(localized: "easter.key.yoga"): String(localized: "easter.val.yoga"),
        String(localized: "easter.key.todo"): String(localized: "easter.val.todo"),
        String(localized: "easter.key.solara"): String(localized: "easter.val.solara"),
        String(localized: "easter.key.nothing"): String(localized: "easter.val.nothing"),
        String(localized: "easter.key.meaningoflife"): String(localized: "easter.val.meaningoflife"),
        String(localized: "easter.key.help"): String(localized: "easter.val.help"),
        String(localized: "easter.key.deletesystem32"): String(localized: "easter.val.deletesystem32"),
        String(localized: "easter.key.coffee"): String(localized: "easter.val.coffee"),
        String(localized: "easter.key.tea"): String(localized: "easter.val.tea"),
        String(localized: "easter.key.manifest"): String(localized: "easter.val.manifest"),
        String(localized: "easter.key.cleanup"): String(localized: "easter.val.cleanup"),
        String(localized: "easter.key.sleep"): String(localized: "easter.val.sleep")
    ]

    // MARK: - Special Easter Egg Messages

    static let consecutiveNoMessage = String(localized: "phrases.special.consecutiveno")
    static let tooManyTasksMessage = String(localized: "phrases.special.toomanytasks")
    static let midnightMessage = String(localized: "phrases.special.midnight")
    static let shakeMessage = String(localized: "phrases.special.shake")
}
