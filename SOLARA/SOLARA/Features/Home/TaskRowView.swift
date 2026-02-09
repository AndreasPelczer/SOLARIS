//
//  TaskRowView.swift
//  SOLARA
//
//  Created by Andreas Pelczer on 09.02.26.
//

import SwiftUI

struct TaskRowView: View {
    let task: TaskItem
    var isGlowing: Bool = false
    var isShaking: Bool = false
    var isDangerFlash: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Text("✦")
                    .font(.caption)
                    .foregroundStyle(SolaraTheme.gold)
                Text(task.title)
                    .font(.body)
                    .foregroundStyle(SolaraTheme.textPrimary)
                Spacer()
            }

            Text(task.cosmicState.rawValue)
                .font(.caption.italic())
                .foregroundStyle(SolaraTheme.textSecondary)

            Rectangle()
                .fill(SolaraTheme.gold.opacity(0.15))
                .frame(height: 0.5)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(SolaraTheme.backgroundCard)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            isDangerFlash ? SolaraTheme.dangerRed :
                            (isGlowing ? SolaraTheme.gold : SolaraTheme.gold.opacity(0.15)),
                            lineWidth: isDangerFlash || isGlowing ? 1.5 : 1
                        )
                )
        )
        .shadow(color: isGlowing ? SolaraTheme.gold.opacity(0.3) : .clear, radius: 8)
        .offset(x: isShaking ? -6 : 0)
        .contentShape(Rectangle())
    }
}
