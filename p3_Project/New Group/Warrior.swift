//
//  Warrior.swift
//  p3_Project
//
//  Created by Birkyboy on 15/03/2021.
//

import Foundation

/// Characters Max Health,  and weapon damages needs to be defined. Temp value for now

class Warrior: Character {
    
    /// Character own max health point
    static let maximumHealth = 100
    /// Character's weapon
    static let weapon = Weapon(name: "Sword", damages: 10, healingPower: 0)
    
    /// - Parameter name: name given by the player
    init(name: String) {
        super.init(name: name,
                   maximumHealth: Warrior.maximumHealth,
                   currentHealth: 100,
                   weapon: Warrior.weapon)
    }
    
   
}
