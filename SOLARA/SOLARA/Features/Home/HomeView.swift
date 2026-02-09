//
//  HomeView.swift
//  SOLARA
//
//  Created by Andreas Pelczer on 09.02.26.
//


import SwiftUI

struct HomeView: View {
    @State var viewModel: HomeViewModel

    var body: some View {
        VStack(spacing: 0) {
            header
            list
        }
        .navigationTitle("SOLARA")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { viewModel.onAppear() }
        .alert("SOLARA", isPresented: $viewModel.popups.isShowing) {
            Button("Verstanden") { viewModel.popups.dismiss() }
        } message: {
            Text(viewModel.popups.message)
        }
        .toolbar {
            NavigationLink("Shop") { StoreView() }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Deine kosmische Liste")
                .font(.title2).bold()

            HStack {
                TextField("Neuer Task…", text: $viewModel.newTaskTitle)
                    .textFieldStyle(.roundedBorder)
                Button("＋") { viewModel.addTask() }
                    .buttonStyle(.borderedProminent)
            }
            .padding(.bottom, 6)

            Text("Satire. SOLARA weiß nichts. Und genau das ist der Punkt.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding()
    }

    private var list: some View {
        List {
            ForEach(viewModel.store.tasks) { task in
                TaskRowView(task: task)
                    .onTapGesture { viewModel.tapped(task) }
                    .swipeActions(edge: .trailing) {
                        Button("Fühlt sich erledigt an") {
                            viewModel.attemptComplete(task)
                        }
                    }
            }
        }
        .listStyle(.insetGrouped)
    }
}
