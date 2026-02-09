//
//  SolaraPopupView.swift
//  SOLARA
//

import SwiftUI

struct SolaraPopupView: View {
    let message: String
    let onDismiss: () -> Void

    @State private var appear = false

    var body: some View {
        ZStack {
            Color.black.opacity(appear ? 0.6 : 0)
                .ignoresSafeArea()
                .onTapGesture { dismiss() }

            VStack(spacing: 16) {
                Text("✦")
                    .font(.title2)
                    .foregroundStyle(SolaraTheme.gold)

                Text("„\(message)"")
                    .font(.callout.italic())
                    .foregroundStyle(SolaraTheme.goldLight)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 8)

                Button {
                    dismiss()
                } label: {
                    Text("Verstanden")
                        .font(.subheadline.bold())
                        .foregroundStyle(SolaraTheme.gold)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(SolaraTheme.gold, lineWidth: 1)
                        )
                }

                Text("✦")
                    .font(.title2)
                    .foregroundStyle(SolaraTheme.gold)
            }
            .padding(28)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(SolaraTheme.backgroundSecondary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(SolaraTheme.gold.opacity(0.2), lineWidth: 1)
                    )
            )
            .padding(.horizontal, 40)
            .scaleEffect(appear ? 1 : 0.85)
            .opacity(appear ? 1 : 0)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.3)) {
                appear = true
            }
        }
    }

    private func dismiss() {
        withAnimation(.easeIn(duration: 0.2)) {
            appear = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            onDismiss()
        }
    }
}
