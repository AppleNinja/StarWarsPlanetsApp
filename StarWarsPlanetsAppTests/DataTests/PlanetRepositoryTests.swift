//
//  PlanetRepositoryTests.swift
//  StarWarsPlanetsAppTests
//
//  Created by Sreekumar on 03/11/2024.
//

import XCTest
import Combine
@testable import StarWarsPlanetsApp

final class PlanetRepositoryTests: XCTestCase {
    var repository: PlanetRepository!
    var remoteDataSource: MockPlanetRemoteDataSource!
    var localDataSource: MockPlanetLocalDataSource!
    var mapper: PlanetMapper!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        remoteDataSource = MockPlanetRemoteDataSource()
        localDataSource = MockPlanetLocalDataSource()
        mapper = PlanetMapper()
        repository = PlanetRepository(
            remoteDataSource: remoteDataSource,
            localDataSource: localDataSource,
            mapper: mapper
        )
        cancellables = []
    }

    override func tearDown() {
        repository = nil
        remoteDataSource = nil
        localDataSource = nil
        mapper = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchPlanetsSuccess() {
        let planetDTO = PlanetDTO(
            name: "Earth",
            rotation_period: "24",
            orbital_period: "365",
            diameter: "12742",
            climate: "temperate",
            gravity: "1 standard",
            terrain: "varied",
            surface_water: "71",
            population: "7800000000"
        )
        remoteDataSource.planetsDTO = [planetDTO]

        let expectation = XCTestExpectation(description: "Fetch planets from repository")
        var resultPlanets: [Planet] = []

        repository.fetchPlanets()
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTFail("Repository fetch failed with error: \(error)")
                }
            }, receiveValue: { planets in
                resultPlanets = planets
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(resultPlanets.count, 1)
        XCTAssertEqual(resultPlanets.first?.name, "Earth")
        XCTAssertEqual(localDataSource.savedPlanets.count, 1)
    }

    func testFetchPlanetsFailureReturnsLocalData() {
        let expectedPlanets = [
            Planet(
                id: "1",
                name: "Mars",
                rotationPeriod: "25",
                orbitalPeriod: "687",
                diameter: "6779",
                climate: "cold",
                gravity: "0.38 standard",
                terrain: "rocky",
                surfaceWater: "0",
                population: "0"
            )
        ]
        localDataSource.savedPlanets = expectedPlanets
        remoteDataSource.error = URLError(.notConnectedToInternet)

        let expectation = XCTestExpectation(description: "Fetch planets from local data source")
        var resultPlanets: [Planet] = []

        repository.fetchPlanets()
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTFail("Repository fetch failed with error: \(error)")
                }
            }, receiveValue: { planets in
                resultPlanets = planets
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(resultPlanets, expectedPlanets)
    }
}
