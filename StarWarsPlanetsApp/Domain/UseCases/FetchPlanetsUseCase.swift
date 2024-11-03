//
//  FetchPlanetsUseCase.swift
//  StarWarsPlanetsApp
//
//  Created by Sreekumar on 03/11/2024.
//

import Foundation
import Combine

protocol FetchPlanetsUseCaseProtocol {
    func execute() -> AnyPublisher<[Planet], Error>
}

final class FetchPlanetsUseCase: FetchPlanetsUseCaseProtocol {
    private let repository: PlanetRepositoryProtocol

    init(repository: PlanetRepositoryProtocol) {
        self.repository = repository
    }

    func execute() -> AnyPublisher<[Planet], Error> {
        return repository.fetchPlanets()
    }
}

