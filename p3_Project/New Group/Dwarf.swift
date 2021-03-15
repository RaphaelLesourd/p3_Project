//
//  Dwarf.swift
//  p3_Project
//
//  Created by Birkyboy on 15/03/2021.
//

import Foundation


/// Characters Max Health,  and weapon damages needs to be defined. Temp value for now

class Dwarf: Character {
    
    /// Character own max health point
    static let maximumHealth = 50
    /// Character's weapon
    static let weapon = Weapon(name: "Axe", damages: 50, healingPower: 0)
    
    /// - Parameter name: name given by the player
    init(name: String) {
        super.init(name: name,
                   maximumHealth: Dwarf.maximumHealth,
                   currentHealth: 50,
                   weapon: Dwarf.weapon)
    }
}
