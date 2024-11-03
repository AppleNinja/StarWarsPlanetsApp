//
//  PlanetDetailView.swift
//  StarWarsPlanetsApp
//
//  Created by Sreekumar on 03/11/2024.
//

import SwiftUI

struct PlanetDetailView: View {
    let planet: Planet
    
    var body: some View {
        Form {
            Section(header: Text("Basic Information")) {
                Text("Name: \(planet.name)")
                    .accessibilityIdentifier("PlanetDetailName")
                Text("Climate: \(planet.climate)")
                Text("Terrain: \(planet.terrain)")
            }
            
            Section(header: Text("Physical Characteristics")) {
                Text("Diameter: \(planet.diameter)")
                Text("Gravity: \(planet.gravity)")
                Text("Surface Water: \(planet.surfaceWater)")
            }
            
            Section(header: Text("Population")) {
                Text("Population: \(planet.population)")
            }
            
            Section(header: Text("Orbital Details")) {
                Text("Rotation Period: \(planet.rotationPeriod)")
                Text("Orbital Period: \(planet.orbitalPeriod)")
            }
        }
        .navigationTitle(planet.name)
    }
}
