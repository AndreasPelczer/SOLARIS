//
//  ShareCardView.swift
//  SOLARA
//

import SwiftUI

struct ShareCardView: View {
    @State private var currentMessage: String = SolaraPhrases.shareCardMessages.randomElement() ?? ""
    @State private var renderedImage: UIImage?

    var body: some View {
        ZStack {
            SolaraTheme.backgroundPrimary
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Text("Teile kosmische Weisheit")
                    .font(.title3.bold())
                    .foregroundStyle(SolaraTheme.gold)

                shareCardPreview
                    .padding(.horizontal, 32)

                HStack(spacing: 16) {
                    Button {
                        currentMessage = SolaraPhrases.shareCardMessages.randomElement() ?? currentMessage
                        renderImage()
                    } label: {
                        Text("✦ Neuer Spruch")
                            .font(.subheadline.bold())
                            .foregroundStyle(SolaraTheme.gold)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(SolaraTheme.gold, lineWidth: 1)
                            )
                    }

                    if let image = renderedImage {
                        ShareLink(
                            item: Image(uiImage: image),
                            preview: SharePreview("SOLARA", image: Image(uiImage: image))
                        ) {
                            Text("Teilen")
                                .font(.subheadline.bold())
                                .foregroundStyle(SolaraTheme.backgroundPrimary)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(SolaraTheme.gold)
                                )
                        }
                    }
                }

                Spacer()
            }
            .padding(.top, 20)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("✦ Teilen ✦")
                    .font(.headline.bold())
                    .foregroundStyle(SolaraTheme.gold)
            }
        }
        .toolbarBackground(SolaraTheme.backgroundPrimary, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear { renderImage() }
    }

    // MARK: - Share Card Preview

    private var shareCardPreview: some View {
        ShareCardContent(message: currentMessage)
            .frame(height: 300)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func renderImage() {
        let renderer = ImageRenderer(content:
            ShareCardContent(message: currentMessage)
                .frame(width: 600, height: 600)
        )
        renderer.scale = 3
        renderedImage = renderer.uiImage
    }
}

// MARK: - Card Content (reusable for rendering)

struct ShareCardContent: View {
    let message: String

    var body: some View {
        ZStack {
            SolaraTheme.backgroundPrimary

            VStack(spacing: 20) {
                Spacer()

                Text("✦")
                    .font(.largeTitle)
                    .foregroundStyle(SolaraTheme.gold)

                Text("„\(message)“")
                    .font(.title3.italic())
                    .foregroundStyle(SolaraTheme.goldLight)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                Text("✦")
                    .font(.largeTitle)
                    .foregroundStyle(SolaraTheme.gold)

                Spacer()

                VStack(spacing: 4) {
                    Text("S O L A R A")
                        .font(.caption.bold())
                        .tracking(4)
                        .foregroundStyle(SolaraTheme.gold)
                    Text("Eine App, die nichts weiß.")
                        .font(.caption2)
                        .foregroundStyle(SolaraTheme.textSecondary)
                }
                .padding(.bottom, 24)
            }
        }
    }
}
