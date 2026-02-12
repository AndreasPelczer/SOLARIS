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
        ZStack {
            SolaraTheme.backgroundPrimary
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header
                if viewModel.store.tasks.isEmpty {
                    emptyState
                } else {
                    taskList
                }
            }

            // Custom popup overlay
            if viewModel.popups.isShowing {
                SolaraPopupView(
                    message: viewModel.popups.message,
                    onDismiss: { viewModel.popups.dismiss() }
                )
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("S O L A R A")
                    .font(.headline.bold())
                    .tracking(4)
                    .foregroundStyle(SolaraTheme.gold)
            }
            ToolbarItem(placement: .topBarTrailing) {
                HStack(spacing: 12) {
                    NavigationLink {
                        ShareCardView()
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundStyle(SolaraTheme.gold)
                    }
                    NavigationLink {
                        StoreView()
                    } label: {
                        Text("✦ Shop")
                            .font(.subheadline)
                            .foregroundStyle(SolaraTheme.gold)
                    }
                }
            }
        }
        .toolbarBackground(SolaraTheme.backgroundPrimary, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear { viewModel.onAppear() }
    }

    // MARK: - Header

    private var header: some View {
        VStack(spacing: 12) {
            Text("✦  S O L A R A  ✦")
                .font(.largeTitle.bold())
                .tracking(6)
                .foregroundStyle(SolaraTheme.gold)
                .scaleEffect(viewModel.titleAppeared ? 1 : 1.05)
                .opacity(viewModel.titleAppeared ? 1 : 0)

            Text("„\(String(localized: "home.subtitle"))"")
                .font(.callout.italic())
                .foregroundStyle(SolaraTheme.textSecondary)

            HStack(spacing: 8) {
                TextField(String(localized: "home.task.placeholder"), text: $viewModel.newTaskTitle)
                    .font(.body)
                    .foregroundStyle(SolaraTheme.textPrimary)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(SolaraTheme.backgroundCard)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(SolaraTheme.gold.opacity(0.3), lineWidth: 1)
                            )
                    )
                    .onSubmit { viewModel.addTask() }

                Button {
                    viewModel.addTask()
                } label: {
                    Text("✦")
                        .font(.title3)
                        .foregroundStyle(SolaraTheme.gold)
                        .frame(width: 44, height: 44)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(SolaraTheme.backgroundCard)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(SolaraTheme.gold.opacity(0.3), lineWidth: 1)
                                )
                        )
                }
            }

            Text(String(localized: "home.disclaimer"))
                .font(.caption2)
                .foregroundStyle(SolaraTheme.textSecondary)
        }
        .padding(.horizontal, 20)
        .padding(.top, 8)
        .padding(.bottom, 16)
    }

    // MARK: - Empty State

    private var emptyState: some View {
        VStack(spacing: 16) {
            Spacer()
            Text("✦")
                .font(.title)
                .foregroundStyle(SolaraTheme.gold)
            Text(SolaraPhrases.emptyStateMessages.randomElement() ?? "Keine Aufgaben.")
                .font(.callout.italic())
                .foregroundStyle(SolaraTheme.textSecondary)
                .multilineTextAlignment(.center)
            Text("✦")
                .font(.title)
                .foregroundStyle(SolaraTheme.gold)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Task List

    private var taskList: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(viewModel.store.tasks) { task in
                    TaskRowView(
                        task: task,
                        isGlowing: viewModel.glowingTaskID == task.id,
                        isShaking: viewModel.shakingTaskID == task.id,
                        isDangerFlash: viewModel.dangerFlashTaskID == task.id
                    )
                    .transition(.asymmetric(
                        insertion: .move(edge: .top).combined(with: .opacity),
                        removal: .move(edge: .trailing).combined(with: .opacity)
                    ))
                    .offset(x: viewModel.completingTaskID == task.id ? 400 : 0)
                    .opacity(viewModel.completingTaskID == task.id ? 0 : 1)
                    .animation(.easeOut(duration: 0.3), value: viewModel.completingTaskID)
                    .onTapGesture { viewModel.tapped(task) }
                    .contextMenu {
                        Button {
                            viewModel.attemptComplete(task)
                        } label: {
                            Label(String(localized: "home.context.complete"), systemImage: "checkmark.circle")
                        }
                        Button(role: .destructive) {
                            viewModel.deleteTask(task)
                        } label: {
                            Label(String(localized: "home.context.delete"), systemImage: "xmark.circle")
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 4)
            .animation(.easeInOut(duration: 0.3), value: viewModel.store.tasks.count)
        }
        .scrollContentBackground(.hidden)
    }
}
