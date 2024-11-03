//
//  MockFetchPlanetsUseCase.swift
//  StarWarsPlanetsAppTests
//
//  Created by Sreekumar on 03/11/2024.
//

import XCTest
import Combine
@testable import StarWarsPlanetsApp

class MockFetchPlanetsUseCase: FetchPlanetsUseCaseProtocol {
    var planets: [Planet] = []
    var error: Error?

    func execute() -> AnyPublisher<[Planet], Error> {
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
