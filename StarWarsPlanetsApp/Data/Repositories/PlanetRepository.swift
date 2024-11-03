//
//  PlanetRepository.swift
//  StarWarsPlanetsApp
//
//  Created by Sreekumar on 03/11/2024.
//

import Foundation
import Combine

protocol PlanetRepositoryProtocol {
    func fetchPlanets() -> AnyPublisher<[Planet], Error>
}

final class PlanetRepository: PlanetRepositoryProtocol {
    private let remoteDataSource: PlanetRemoteDataSourceProtocol
    private let localDataSource: PlanetLocalDataSourceProtocol
    private let mapper: PlanetMapperProtocol

    init(remoteDataSource: PlanetRemoteDataSourceProtocol,
         localDataSource: PlanetLocalDataSourceProtocol,
         mapper: PlanetMapperProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
        self.mapper = mapper
    }

    func fetchPlanets() -> AnyPublisher<[Planet], Error> {
        return remoteDataSource.fetchPlanets()
            .map { [weak self] dtoList in
                let planets = dtoList.compactMap { self?.mapper.mapDTOToDomain($0) }
                self?.localDataSource.savePlanets(planets: planets)
                return planets
            }
            .catch { [weak self] _ in
                return Just(self?.localDataSource.getPlanets() ?? [])
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
