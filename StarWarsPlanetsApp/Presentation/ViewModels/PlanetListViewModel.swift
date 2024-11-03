//
//  PlanetListViewModel.swift
//  StarWarsPlanetsApp
//
//  Created by Sreekumar on 03/11/2024.
//

import Foundation
import Combine

final class PlanetListViewModel: ObservableObject {
    @Published var planets: [Planet] = []
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    var errorMessage: String?

    private let fetchPlanetsUseCase: FetchPlanetsUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()

    init(fetchPlanetsUseCase: FetchPlanetsUseCaseProtocol) {
        self.fetchPlanetsUseCase = fetchPlanetsUseCase
    }

    func fetchPlanets() {
        isLoading = true
        fetchPlanetsUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                    self?.showError = true
                    print("Error fetching planets: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] planets in
                self?.planets = planets
                print("ViewModel received \(planets.count) planets")
            })
            .store(in: &cancellables)
    }
}


