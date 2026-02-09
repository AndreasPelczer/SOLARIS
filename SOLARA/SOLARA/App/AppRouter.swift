//
//  AppRouter.swift
//  SOLARA
//
//  Created by Andreas Pelczer on 09.02.26.
//

import SwiftUI

struct AppRouter: View {
    var body: some View {
        NavigationStack {
            HomeView(viewModel: HomeViewModel())
        }
        .tint(SolaraTheme.gold)
    }
}
