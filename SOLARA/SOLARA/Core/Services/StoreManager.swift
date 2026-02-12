//
//  StoreManager.swift
//  SOLARA
//
//  StoreKit 2 Service for consumable IAP products.
//  No restore logic needed: Apple does not require (and discourages)
//  restore for consumables, since they have no persistent entitlement.
//

import StoreKit
import SwiftUI

/// Result of a purchase attempt.
enum PurchaseResult {
    case success
    case cancelled
    case pending
    case failed(Error)
}

@Observable
@MainActor
final class StoreManager {

    // MARK: - Public State

    /// Loaded StoreKit products, keyed by product ID for fast lookup.
    private(set) var products: [Product] = []

    /// True while products are being fetched from the App Store.
    private(set) var isLoading = false

    /// Non-nil if product loading failed.
    private(set) var loadError: String?

    /// True while a purchase is in progress (disables buy buttons).
    private(set) var isPurchasing = false

    // MARK: - Product IDs

    /// The four consumable product identifiers.
    /// Must match App Store Connect and the StoreKit Configuration file exactly.
    static let productIDs: [String] = [
        "solara.tea",
        "solara.stone",
        "solara.mercurykit",
        "solara.patron"
    ]

    // MARK: - Init

    init() {
        // Start listening for transactions finished outside the app
        // (e.g. Ask to Buy approved, interrupted purchases).
        startTransactionListener()
    }

    // MARK: - Load Products

    /// Fetches products from the App Store (or StoreKit Config in debug).
    /// Caches the result in-memory; call again to refresh.
    func loadProducts() async {
        guard !isLoading else { return }
        isLoading = true
        loadError = nil

        do {
            let storeProducts = try await Product.products(for: Self.productIDs)
            // Sort by price so the cheapest item appears first.
            products = storeProducts.sorted { $0.price < $1.price }
        } catch {
            loadError = error.localizedDescription
            products = []
        }

        isLoading = false
    }

    // MARK: - Purchase

    /// Initiates a purchase for the given product.
    /// Returns a `PurchaseResult` so the UI can react accordingly.
    func purchase(_ product: Product) async -> PurchaseResult {
        isPurchasing = true
        defer { isPurchasing = false }

        do {
            let result = try await product.purchase()

            switch result {
            case .success(let verification):
                switch verification {
                case .verified(let transaction):
                    // Consumable: finish immediately, no entitlement to persist.
                    await transaction.finish()
                    return .success

                case .unverified(_, let error):
                    return .failed(error)
                }

            case .userCancelled:
                return .cancelled

            case .pending:
                // e.g. Ask to Buy, parental approval pending
                return .pending

            @unknown default:
                return .cancelled
            }
        } catch {
            return .failed(error)
        }
    }

    // MARK: - Transaction Listener

    /// Listens for transactions that arrive while the app is running
    /// (e.g. deferred purchases approved later).
    private func startTransactionListener() {
        Task.detached { [weak self] in
            for await result in Transaction.updates {
                guard let self else { return }
                if case .verified(let transaction) = result {
                    await transaction.finish()
                }
            }
        }
    }
}
