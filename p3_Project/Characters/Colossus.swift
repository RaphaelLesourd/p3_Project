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

class Colossus: Character {
   
    /// Character  initial full life
    static let initialLife = 80
    /// Character's weapon
    static let weapon = Weapon(name: "Punch", damages: 35, healingPower: 0)
    static let icon = "💪"
    
    /// - Parameter name: name given by the player
    init(name: String) {
        super.init(name: name,
                   icon: Colossus.icon,
                   life: Colossus.initialLife,
                   canHeal: false,
                   weapon: Colossus.weapon)
    }
}
