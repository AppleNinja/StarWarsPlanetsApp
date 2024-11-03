//
//  PlanetRemoteDataSource.swift
//  StarWarsPlanetsApp
//
//  Created by Sreekumar on 03/11/2024.
//

import Foundation
import Combine

protocol PlanetRemoteDataSourceProtocol {
    func fetchPlanets() -> AnyPublisher<[PlanetDTO], Error>
}

final class PlanetRemoteDataSource: PlanetRemoteDataSourceProtocol {
    func fetchPlanets() -> AnyPublisher<[PlanetDTO], Error> {
        guard let url = URL(string: "https://swapi.dev/api/planets/") else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: PlanetResponseDTO.self, decoder: JSONDecoder())
            .map { $0.results }
            .eraseToAnyPublisher()
    }
}
