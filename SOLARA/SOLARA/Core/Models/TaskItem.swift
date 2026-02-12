//
//  TaskItem.swift
//  SOLARA
//
//  Created by Andreas Pelczer on 09.02.26.
//

import Foundation
import SwiftUI

struct TaskItem: Identifiable, Equatable, Codable {
    enum CosmicState: String, CaseIterable, Codable {
        case imFluss            = "flowing"
        case blockiert          = "blocked"
        case nichtManifestiert  = "unmanifested"
        case loslassen          = "letgo"
        case kosmischesTiming   = "timing"
        case astralVerschoben   = "astral"
        case wartetAufZeichen   = "sign"
        case quantenverschraenkt = "quantum"
        case retrograd          = "retrograde"
        case univerumPrueft     = "checking"

        private static let legacyMapping: [String: CosmicState] = [
            "✨ Im kosmischen Fluss": .imFluss,
            "🌫️ Energetisch blockiert": .blockiert,
            "🔮 Noch nicht manifestiert": .nichtManifestiert,
            "🕯️ Loslassen empfohlen": .loslassen,
            "🌙 Wartet auf kosmisches Timing": .kosmischesTiming,
            "💫 Astral verschoben": .astralVerschoben,
            "🌠 Wartet auf ein Zeichen": .wartetAufZeichen,
            "⚛️ Quantenverschränkt": .quantenverschraenkt,
            "🪐 Retrograd verschoben": .retrograd,
            "🔭 Das Universum prüft noch": .univerumPrueft
        ]

        var localizedName: String {
            switch self {
            case .imFluss:            return "✨ " + String(localized: "cosmic.state.flowing")
            case .blockiert:          return "🌫️ " + String(localized: "cosmic.state.blocked")
            case .nichtManifestiert:  return "🔮 " + String(localized: "cosmic.state.unmanifested")
            case .loslassen:          return "🕯️ " + String(localized: "cosmic.state.letgo")
            case .kosmischesTiming:   return "🌙 " + String(localized: "cosmic.state.timing")
            case .astralVerschoben:   return "💫 " + String(localized: "cosmic.state.astral")
            case .wartetAufZeichen:   return "🌠 " + String(localized: "cosmic.state.sign")
            case .quantenverschraenkt: return "⚛️ " + String(localized: "cosmic.state.quantum")
            case .retrograd:          return "🪐 " + String(localized: "cosmic.state.retrograde")
            case .univerumPrueft:     return "🔭 " + String(localized: "cosmic.state.checking")
            }
        }

        init(from decoder: Decoder) throws {
            let value = try decoder.singleValueContainer().decode(String.self)
            if let state = CosmicState(rawValue: value) {
                self = state
            } else if let state = CosmicState.legacyMapping[value] {
                self = state
            } else {
                self = .blockiert
            }
        }
    }

    let id: UUID
    var title: String
    var createdAt: Date
    var cosmicState: CosmicState
    var consecutiveNoCount: Int

    init(id: UUID = UUID(),
         title: String,
         createdAt: Date = Date(),
         cosmicState: CosmicState = .blockiert,
         consecutiveNoCount: Int = 0) {
        self.id = id
        self.title = title
        self.createdAt = createdAt
        self.cosmicState = cosmicState
        self.consecutiveNoCount = consecutiveNoCount
    }
}
