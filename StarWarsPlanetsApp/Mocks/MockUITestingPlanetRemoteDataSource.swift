//
//  MockUITestingPlanetRemoteDataSource.swift
//  StarWarsPlanetsAppTests
//
//  Created by Sreekumar on 03/11/2024.
//

#if UITESTING

import Foundation
import Combine

class MockUITestingPlanetRemoteDataSource: PlanetRemoteDataSourceProtocol {
    func fetchPlanets() -> AnyPublisher<[PlanetDTO], Error> {
        let planetDTOs = [
            PlanetDTO(
                name: "Earth",
                rotation_period: "24",
                orbital_period: "365",
                diameter: "12742",
                climate: "temperate",
                gravity: "1 standard",
                terrain: "varied",
                surface_water: "71",
                population: "7800000000"
            ),
        ]
        return Just(planetDTOs)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

#endif
