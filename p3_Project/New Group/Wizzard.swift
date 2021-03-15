//
//  Wizzard.swift
//  p3_Project
//
//  Created by Birkyboy on 15/03/2021.
//

import Foundation


/// Characters Max Health,  and weapon damages needs to be defined. Temp value for now

class Wizzard: Character {
    
    /// Character own max health point
    static let maximumHealth = 50
    /// Character's weapon
    static let wand = Weapon(name: "Magic Wand", damages: 0, healingPower: 100)
    
    /// - Parameter name: name given by the player
    init(name: String) {
        super.init(name: name,
                   maximumHealth: Wizzard.maximumHealth,
                   currentHealth: 50,
                   weapon: Wizzard.wand)
    }
}
