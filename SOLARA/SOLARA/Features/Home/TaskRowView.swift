//
//  TaskRowView.swift
//  SOLARA
//
//  Created by Andreas Pelczer on 09.02.26.
//


import SwiftUI

struct TaskRowView: View {
    let task: TaskItem

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .font(.headline)
                Text(task.cosmicState.rawValue)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .contentShape(Rectangle())
    }
}
