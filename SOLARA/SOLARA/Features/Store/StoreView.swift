//
//  StoreView.swift
//  SOLARA
//
//  Created by Andreas Pelczer on 09.02.26.
//

import SwiftUI
import StoreKit

struct StoreView: View {
    @State private var showThankYou = false
    @State private var purchasedItemName = ""

    private let products: [CosmicProduct] = [
        CosmicProduct(
            emoji: "🍵",
            title: "Kosmischer Tee",
            subtitle: "Kauf dem SOLARA-Team einen Tee. Er ist nicht kosmisch. Aber er ist warm.",
            price: "0,99 €",
            productID: "solara.tea"
        ),
        CosmicProduct(
            emoji: "🪨",
            title: "Virtueller Heilstein",
            subtitle: "Existiert nicht. Funktioniert trotzdem (gefühlt). Schützt vor gar nichts.",
            price: "2,99 €",
            productID: "solara.stone"
        ),
        CosmicProduct(
            emoji: "🌙",
            title: "Merkur-Rückläufig-Survival-Kit",
            subtitle: "Enthält: einen kosmischen Backup-Stein, einen digitalen Schutzkreis, eine Affirmation die nichts bedeutet.",
            price: "4,99 €",
            productID: "solara.mercurykit"
        ),
        CosmicProduct(
            emoji: "✨",
            title: "Kosmisches Mäzenatentum",
            subtitle: "Du unterstützt eine App, die nichts kann. Das ist das Schönste, was je jemand getan hat.",
            price: "9,99 €",
            productID: "solara.patron"
        )
    ]

    var body: some View {
        ZStack {
            SolaraTheme.backgroundPrimary
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    storeHeader
                    disclaimer

                    ForEach(products) { product in
                        productCard(product)
                    }

                    refundFooter
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
            }

            if showThankYou {
                thankYouOverlay
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("✦ Shop ✦")
                    .font(.headline.bold())
                    .foregroundStyle(SolaraTheme.gold)
            }
        }
        .toolbarBackground(SolaraTheme.backgroundPrimary, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }

    // MARK: - Header

    private var storeHeader: some View {
        VStack(spacing: 8) {
            Text("✦ Kosmischer Geschenkeladen ✦")
                .font(.title3.bold())
                .foregroundStyle(SolaraTheme.gold)
            Text("\u{201E}Nichts hier tut etwas. Alles hier ist schön.\u{201C}")
                .font(.callout.italic())
                .foregroundStyle(SolaraTheme.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 8)
    }

    // MARK: - Disclaimer

    private var disclaimer: some View {
        Text("Du brauchst hier nichts zu kaufen. Wirklich nicht. Wenn du trotzdem etwas kaufst, unterstützt du ein kleines Team, das eine sinnlose App baut. Das ist irgendwie schön.")
            .font(.caption.italic())
            .foregroundStyle(SolaraTheme.textSecondary)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 8)
    }

    // MARK: - Product Card

    private func productCard(_ product: CosmicProduct) -> some View {
        VStack(spacing: 12) {
            Text(product.emoji)
                .font(.system(size: 48))

            Text(product.title)
                .font(.headline.bold())
                .foregroundStyle(SolaraTheme.gold)

            Text(product.subtitle)
                .font(.subheadline)
                .foregroundStyle(SolaraTheme.textPrimary)
                .multilineTextAlignment(.center)

            Text(product.price)
                .font(.caption.bold())
                .foregroundStyle(SolaraTheme.gold)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(
                    Capsule()
                        .fill(SolaraTheme.gold.opacity(0.1))
                )

            Button {
                purchasedItemName = product.title
                showThankYou = true
            } label: {
                Text("Unterstützen")
                    .font(.subheadline.bold())
                    .foregroundStyle(SolaraTheme.gold)
                    .padding(.horizontal, 28)
                    .padding(.vertical, 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(SolaraTheme.gold, lineWidth: 1)
                    )
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(SolaraTheme.backgroundCard)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(SolaraTheme.gold.opacity(0.15), lineWidth: 1)
                )
        )
    }

    // MARK: - Refund Footer

    private var refundFooter: some View {
        Text("Falls du knapp bei Kasse bist: Kauf bitte nichts. Wir meinen das ernst. SOLARA funktioniert komplett ohne Geld. Jeder Kauf kann jederzeit über Apple erstattet werden.")
            .font(.caption2.italic())
            .foregroundStyle(SolaraTheme.textSecondary)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 8)
            .padding(.bottom, 20)
    }

    // MARK: - Thank You Overlay

    private var thankYouOverlay: some View {
        SolaraPopupView(
            message: "Danke. Wir wissen das zu schätzen.\nDein \(purchasedItemName) tut übrigens nichts.\nAber du hast etwas getan.",
            onDismiss: { showThankYou = false }
        )
    }
}

// MARK: - Cosmic Product Model

struct CosmicProduct: Identifiable {
    let id = UUID()
    let emoji: String
    let title: String
    let subtitle: String
    let price: String
    let productID: String
}
