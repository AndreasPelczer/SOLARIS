//
//  StoreView.swift
//  SOLARA
//
//  Created by Andreas Pelczer on 09.02.26.
//


import SwiftUI

struct StoreView: View {
    var body: some View {
        List {
            Section("Virtuelle Waren (ändern nichts, außer dein Gefühl)") {
                storeRow(title: "🪨 Virtueller Heilstein", price: "4,99 €",
                         subtitle: "Existiert nicht. Funktioniert trotzdem (gefühlt).")
                storeRow(title: "🌈 Kosmische Klarheit (24h)", price: "1,99 €",
                         subtitle: "Heute weißt du alles. Morgen wieder wie gewohnt.")
                storeRow(title: "🧘 Premium Enlightenment", price: "5,99 €/Monat",
                         subtitle: "Mehr Einsichten. Weniger Antworten. Kündbar.")
            }
        }
        .navigationTitle("Shop")
    }

    private func storeRow(title: String, price: String, subtitle: String) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title).font(.headline)
                Text(subtitle).font(.subheadline).foregroundStyle(.secondary)
            }
            Spacer()
            Text(price).foregroundStyle(.secondary)
        }
        .padding(.vertical, 6)
    }
}
