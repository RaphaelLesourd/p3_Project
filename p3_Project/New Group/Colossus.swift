//
//  Colossus.swift
//  p3_Project
//
//  Created by Birkyboy on 15/03/2021.
//

import Foundation

/// Characters requirements
/// health : High
/// damages: Low
/// healing: None

class Colossus: Companion {
    
    /// Character own max life point
    static let maxLife = 100
    /// Character's weapon
    static let weapon = Weapon(name: "Punch", damages: 5, healingPower: 0)
    static let icon = "💪"
    
    /// - Parameter name: name given by the player
    init(name: String) {
        super.init(name: name,
                   icon: Colossus.icon,
                   maximumLife: Colossus.maxLife,
                   currentLife: Colossus.maxLife,
                   weapon: Colossus.weapon)
    }
}
