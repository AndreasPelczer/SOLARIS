//
//  TaskItem.swift
//  SOLARA
//
//  Created by Andreas Pelczer on 09.02.26.
//

import Foundation

struct TaskItem: Identifiable, Equatable {
    enum CosmicState: String, CaseIterable {
        case imFluss            = "✨ Im kosmischen Fluss"
        case blockiert          = "🌫️ Energetisch blockiert"
        case nichtManifestiert  = "🔮 Noch nicht manifestiert"
        case loslassen          = "🕯️ Loslassen empfohlen"
        case kosmischesTiming   = "🌙 Wartet auf kosmisches Timing"
        case astralVerschoben   = "💫 Astral verschoben"
        case wartetAufZeichen   = "🌠 Wartet auf ein Zeichen"
        case quantenverschraenkt = "⚛️ Quantenverschränkt"
        case retrograd          = "🪐 Retrograd verschoben"
        case univerumPrueft     = "🔭 Das Universum prüft noch"
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
