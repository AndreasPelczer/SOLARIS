//
//  TaskItem.swift
//  SOLARA
//
//  Created by Andreas Pelczer on 09.02.26.
//


import Foundation

struct TaskItem: Identifiable, Equatable {
    enum CosmicState: String, CaseIterable {
        case imFluss = "✨ Im Fluss"
        case blockiert = "🌫️ Energetisch blockiert"
        case nichtManifestiert = "🔮 Noch nicht manifestiert"
        case loslassen = "🕯️ Loslassen empfohlen"
        case kosmischesTiming = "🌙 Wartet auf kosmisches Timing"
    }

    let id: UUID
    var title: String
    var createdAt: Date
    var cosmicState: CosmicState

    init(id: UUID = UUID(),
         title: String,
         createdAt: Date = Date(),
         cosmicState: CosmicState = .blockiert) {
        self.id = id
        self.title = title
        self.createdAt = createdAt
        self.cosmicState = cosmicState
    }
}
