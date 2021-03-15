//
//  Dwarf.swift
//  p3_Project
//
//  Created by Birkyboy on 15/03/2021.
//

import Foundation

/// Characters requirements
/// health : low
/// damages: high
/// healing: None

class Dwarf: Character {
    
    /// Character own max health point
    static let maximumHealth = 50
    /// Character's weapon
    static let weapon = Weapon(name: "Axe", damages: 50, healingPower: 0)
    static let icon = "👩‍🦲"
    
    /// - Parameter name: name given by the player
    init(name: String) {
        super.init(name: name,
                   icon: Dwarf.icon,
                   maximumHealth: Dwarf.maximumHealth,
                   currentHealth: Dwarf.maximumHealth,
                   weapon: Dwarf.weapon)
    }
}
