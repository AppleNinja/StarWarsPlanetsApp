//
//  FetchPlanetsUseCaseTests.swift
//  StarWarsPlanetsAppTests
//
//  Created by Sreekumar on 03/11/2024.
//

import XCTest
import Combine
@testable import StarWarsPlanetsApp

final class FetchPlanetsUseCaseTests: XCTestCase {
    var useCase: FetchPlanetsUseCase!
    var repository: MockPlanetRepository!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        repository = MockPlanetRepository()
        useCase = FetchPlanetsUseCase(repository: repository)
        cancellables = []
    }

    override func tearDown() {
        useCase = nil
        repository = nil
        cancellables = nil
        super.tearDown()
    }

    func testExecuteReturnsPlanets() {
        let expectedPlanets = [
            Planet(
                id: "1",
                name: "Earth",
                rotationPeriod: "24",
                orbitalPeriod: "365",
                diameter: "12742",
                climate: "temperate",
                gravity: "1 standard",
                terrain: "varied",
                surfaceWater: "71",
                population: "7800000000"
            )
        ]
        repository.planets = expectedPlanets

        let expectation = XCTestExpectation(description: "Fetch planets")
        var resultPlanets: [Planet] = []

        useCase.execute()
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTFail("Use case execution failed with error: \(error)")
                }
            }, receiveValue: { planets in
                resultPlanets = planets
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(resultPlanets, expectedPlanets)
    }

    func testExecuteReturnsError() {
        let expectedError = NSError(domain: "", code: -1, userInfo: nil)
        repository.error = expectedError

        let expectation = XCTestExpectation(description: "Fetch planets with error")
        var receivedError: Error?

        useCase.execute()
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    receivedError = error
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Use case should have failed")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(receivedError)
    }
}
