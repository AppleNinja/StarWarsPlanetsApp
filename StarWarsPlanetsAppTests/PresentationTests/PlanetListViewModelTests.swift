//
//  PlanetListViewModelTests.swift
//  StarWarsPlanetsAppTests
//
//  Created by Sreekumar on 03/11/2024.
//

import XCTest
import Combine
@testable import StarWarsPlanetsApp

final class PlanetListViewModelTests: XCTestCase {
    var viewModel: PlanetListViewModel!
    var useCase: MockFetchPlanetsUseCase!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        useCase = MockFetchPlanetsUseCase()
        viewModel = PlanetListViewModel(fetchPlanetsUseCase: useCase)
        cancellables = []
    }
    
    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }

    func testFetchPlanetsUpdatesPlanets() {

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
        useCase.planets = expectedPlanets


        let expectation = XCTestExpectation(description: "Planets are fetched and updated")
        viewModel.$planets
            .dropFirst()
            .sink { planets in
                if planets == expectedPlanets {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.fetchPlanets()


        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(viewModel.planets, expectedPlanets)
    }
}
