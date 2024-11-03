//
//  MockPlanetLocalDataSource.swift
//  StarWarsPlanetsAppTests
//
//  Created by Sreekumar on 03/11/2024.
//

#if UITESTING

import Foundation
import Combine

class MockPlanetLocalDataSource: PlanetLocalDataSourceProtocol {
    var savedPlanets: [Planet] = []

    func savePlanets(planets: [Planet]) {
        savedPlanets = planets
    }

    func getPlanets() -> [Planet] {
        return savedPlanets
    }
}

#endif
