//
//  RootView.swift
//  StarWarsPlanetsApp
//
//  Created by Sreekumar on 03/11/2024.
//

import SwiftUI

struct RootView: View {
    var viewModel: PlanetListViewModel

    init() {
        let isUITesting = ProcessInfo.processInfo.arguments.contains("--uitesting")
        let remoteDataSource: PlanetRemoteDataSourceProtocol
        let localDataSource: PlanetLocalDataSourceProtocol

        if isUITesting {
            remoteDataSource = MockUITestingPlanetRemoteDataSource()
            localDataSource = MockPlanetLocalDataSource()
        } else {
            remoteDataSource = PlanetRemoteDataSource()
            localDataSource = PlanetLocalDataSource()
        }

        let mapper = PlanetMapper()
        let repository = PlanetRepository(
            remoteDataSource: remoteDataSource,
            localDataSource: localDataSource,
            mapper: mapper
        )
        let useCase = FetchPlanetsUseCase(repository: repository)
        self.viewModel = PlanetListViewModel(fetchPlanetsUseCase: useCase)
    }

    var body: some View {
        PlanetListView(viewModel: viewModel)
    }
}
