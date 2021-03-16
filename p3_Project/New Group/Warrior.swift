//
//  Warrior.swift
//  p3_Project
//
//  Created by Birkyboy on 15/03/2021.
//

import Foundation

/// Characters requirements
/// health : High 100 as per request
/// damages: Low  10 as per request
/// healing: None
class Warrior: Companion {
    
    /// Character own max life point
    static let maxLife = 100
    /// Character's weapon
    static let weapon = Weapon(name: "Sword", damages: 10, healingPower: 0)
    static let icon = "👺"
    
    /// - Parameter name: name given by the player
    init(name: String) {
        super.init(name: name,
                   icon: Warrior.icon,
                   maximumLife: Warrior.maxLife,
                   currentLife: Warrior.maxLife,
                   weapon: Warrior.weapon)
    }
    
   
}
