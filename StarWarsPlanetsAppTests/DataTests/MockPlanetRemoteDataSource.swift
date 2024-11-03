//
//  MockPlanetRemoteDataSource.swift
//  StarWarsPlanetsAppTests
//
//  Created by Sreekumar on 03/11/2024.
//

import XCTest
import Combine
@testable import StarWarsPlanetsApp

class MockPlanetRemoteDataSource: PlanetRemoteDataSourceProtocol {
    var planetsDTO: [PlanetDTO] = []
    var error: Error?

    func fetchPlanets() -> AnyPublisher<[PlanetDTO], Error> {
        if let error = error {
            return Fail(error: error)
                .eraseToAnyPublisher()
        } else {
            return Just(planetsDTO)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
