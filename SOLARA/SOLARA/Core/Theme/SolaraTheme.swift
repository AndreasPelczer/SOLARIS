//
//  SolaraTheme.swift
//  SOLARA
//

import SwiftUI

enum SolaraTheme {
    // MARK: - Backgrounds
    static let backgroundPrimary = Color(hex: "0D0B1A")
    static let backgroundSecondary = Color(hex: "1A1533")
    static let backgroundCard = Color(hex: "231E3D")

    // MARK: - Accents
    static let gold = Color(hex: "C9A84C")
    static let goldLight = Color(hex: "E8D48B")

    // MARK: - Text
    static let textPrimary = Color(hex: "F0EAD6")
    static let textSecondary = Color(hex: "8B7FB5")

    // MARK: - Cosmic
    static let cosmicPurple = Color(hex: "6B4FA0")
    static let cosmicPink = Color(hex: "9B4D8A")
    static let dangerRed = Color(hex: "8B3A3A")
}

// MARK: - Color+Hex

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: Double
        switch hex.count {
        case 6:
            r = Double((int >> 16) & 0xFF) / 255.0
            g = Double((int >> 8) & 0xFF) / 255.0
            b = Double(int & 0xFF) / 255.0
        case 8:
            r = Double((int >> 24) & 0xFF) / 255.0
            g = Double((int >> 16) & 0xFF) / 255.0
            b = Double((int >> 8) & 0xFF) / 255.0
        default:
            r = 0; g = 0; b = 0
        }
        self.init(red: r, green: g, blue: b)
    }
}
