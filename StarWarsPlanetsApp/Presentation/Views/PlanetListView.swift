//
//  PlanetListView.swift
//  StarWarsPlanetsApp
//
//  Created by Sreekumar on 03/11/2024.
//

import SwiftUI

struct PlanetListView: View {
    @StateObject private var viewModel: PlanetListViewModel

    init(viewModel: PlanetListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            List(viewModel.planets) { planet in
                NavigationLink(destination: PlanetDetailView(planet: planet)) {
                    PlanetRowView(planet: planet)
                }
            }
            .accessibilityIdentifier("PlanetListTableView")
            .navigationTitle("Planets")
            .onAppear {
                viewModel.fetchPlanets()
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                }
            }
            .alert(isPresented: $viewModel.showError) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage ?? "An unknown error occurred"),
                    dismissButton: .default(Text("OK")) {
                        viewModel.errorMessage = nil
                    }
                )
            }
        }
    }
}
