//
//  MockPlanetRepository.swift
//  StarWarsPlanetsAppTests
//
//  Created by Sreekumar on 03/11/2024.
//

import Foundation
import Combine
@testable import StarWarsPlanetsApp

class MockPlanetRepository: PlanetRepositoryProtocol {
    var planets: [Planet] = []
    var error: Error?

    func fetchPlanets() -> AnyPublisher<[Planet], Error> {
        if let error = error {
            return Fail(error: error)
                .eraseToAnyPublisher()
        } else {
            return Just(planets)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
