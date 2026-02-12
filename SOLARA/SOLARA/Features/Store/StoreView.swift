//
//  StoreView.swift
//  SOLARA
//
//  Created by Andreas Pelczer on 09.02.26.
//

import SwiftUI
import StoreKit

struct StoreView: View {
    @State private var storeManager = StoreManager()
    @State private var showThankYou = false
    @State private var showPending = false
    @State private var showCancelled = false
    @State private var showFailed = false

    /// Emoji mapping for known product IDs.
    private let emojiMap: [String: String] = [
        "solara.tea": "🍵",
        "solara.stone": "🪨",
        "solara.mercurykit": "🌙",
        "solara.patron": "✨"
    ]

    /// Localized subtitle keys for known product IDs.
    private let subtitleKeyMap: [String: LocalizedStringKey] = [
        "solara.tea": "shop.item.tea.subtitle",
        "solara.stone": "shop.item.stone.subtitle",
        "solara.mercurykit": "shop.item.mercurykit.subtitle",
        "solara.patron": "shop.item.patron.subtitle"
    ]

    var body: some View {
        ZStack {
            SolaraTheme.backgroundPrimary
                .ignoresSafeArea()

            Group {
                if storeManager.isLoading {
                    loadingState
                } else if storeManager.loadError != nil {
                    errorState
                } else if storeManager.products.isEmpty {
                    errorState
                } else {
                    productList
                }
            }

            // MARK: - Overlays
            if showThankYou {
                thankYouOverlay
            }
            if showPending {
                pendingOverlay
            }
            if showCancelled {
                cancelledOverlay
            }
            if showFailed {
                failedOverlay
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
        .task {
            await storeManager.loadProducts()
        }
    }

    // MARK: - Loading State

    private var loadingState: some View {
        VStack(spacing: 16) {
            Spacer()
            ProgressView()
                .tint(SolaraTheme.gold)
            Text("shop.state.loading")
                .font(.callout.italic())
                .foregroundStyle(SolaraTheme.textSecondary)
            Spacer()
        }
    }

    // MARK: - Error State

    private var errorState: some View {
        VStack(spacing: 16) {
            Spacer()
            Text("✦")
                .font(.title)
                .foregroundStyle(SolaraTheme.gold)
            Text("shop.state.error")
                .font(.callout.italic())
                .foregroundStyle(SolaraTheme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            Button {
                Task { await storeManager.loadProducts() }
            } label: {
                Text("↻")
                    .font(.title2)
                    .foregroundStyle(SolaraTheme.gold)
                    .padding(12)
                    .overlay(
                        Circle()
                            .stroke(SolaraTheme.gold.opacity(0.3), lineWidth: 1)
                    )
            }
            Spacer()
        }
    }

    // MARK: - Product List

    private var productList: some View {
        ScrollView {
            VStack(spacing: 20) {
                storeHeader
                disclaimer

                ForEach(storeManager.products, id: \.id) { product in
                    productCard(product)
                }

                refundFooter
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
    }

    // MARK: - Header

    private var storeHeader: some View {
        VStack(spacing: 8) {
            Text("shop.title")
                .font(.title3.bold())
                .foregroundStyle(SolaraTheme.gold)
            Text("shop.intro")
                .font(.callout.italic())
                .foregroundStyle(SolaraTheme.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 8)
    }

    // MARK: - Disclaimer

    private var disclaimer: some View {
        Text("shop.disclaimer")
            .font(.caption.italic())
            .foregroundStyle(SolaraTheme.textSecondary)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 8)
    }

    // MARK: - Product Card

    private func productCard(_ product: Product) -> some View {
        VStack(spacing: 12) {
            Text(emojiMap[product.id] ?? "✦")
                .font(.system(size: 48))

            Text(product.displayName)
                .font(.headline.bold())
                .foregroundStyle(SolaraTheme.gold)

            if let subtitleKey = subtitleKeyMap[product.id] {
                Text(subtitleKey)
                    .font(.subheadline)
                    .foregroundStyle(SolaraTheme.textPrimary)
                    .multilineTextAlignment(.center)
            }

            Text(product.displayPrice)
                .font(.caption.bold())
                .foregroundStyle(SolaraTheme.gold)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(
                    Capsule()
                        .fill(SolaraTheme.gold.opacity(0.1))
                )

            Button {
                Task { await handlePurchase(product) }
            } label: {
                Group {
                    if storeManager.isPurchasing {
                        ProgressView()
                            .tint(SolaraTheme.gold)
                    } else {
                        Text("shop.cta.support")
                            .font(.subheadline.bold())
                    }
                }
                .foregroundStyle(SolaraTheme.gold)
                .padding(.horizontal, 28)
                .padding(.vertical, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(SolaraTheme.gold, lineWidth: 1)
                )
            }
            .disabled(storeManager.isPurchasing)
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
        Text("shop.refund.note")
            .font(.caption2.italic())
            .foregroundStyle(SolaraTheme.textSecondary)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 8)
            .padding(.bottom, 20)
    }

    // MARK: - Purchase Handler

    private func handlePurchase(_ product: Product) async {
        let result = await storeManager.purchase(product)

        switch result {
        case .success:
            showThankYou = true
        case .cancelled:
            showCancelled = true
        case .pending:
            showPending = true
        case .failed:
            showFailed = true
        }
    }

    // MARK: - Thank You Overlay

    private var thankYouOverlay: some View {
        SolaraPopupView(
            title: String(localized: "shop.thankyou.title"),
            message: String(localized: "shop.thankyou.body"),
            onDismiss: { showThankYou = false }
        )
    }

    // MARK: - Pending Overlay

    private var pendingOverlay: some View {
        SolaraPopupView(
            message: String(localized: "shop.state.pending"),
            onDismiss: { showPending = false }
        )
    }

    // MARK: - Cancelled Overlay

    private var cancelledOverlay: some View {
        SolaraPopupView(
            message: String(localized: "shop.purchase.cancelled"),
            onDismiss: { showCancelled = false }
        )
    }

    // MARK: - Failed Overlay

    private var failedOverlay: some View {
        SolaraPopupView(
            message: String(localized: "shop.purchase.failed"),
            onDismiss: { showFailed = false }
        )
    }
}
