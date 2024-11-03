//
//  PlanetRowView.swift
//  StarWarsPlanetsApp
//
//  Created by Sreekumar on 03/11/2024.
//

import Foundation
import SwiftUI

struct PlanetRowView: View {
    let planet: Planet

    var body: some View {
        Text(planet.name)
            .accessibilityIdentifier("PlanetRow_\(planet.name)")
    }
}
