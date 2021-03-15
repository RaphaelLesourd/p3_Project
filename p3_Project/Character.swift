//
//  Character.swift
//  p3_Project
//
//  Created by Birkyboy on 14/03/2021.
//

import Foundation


/// This class defines the characters properties

class Character {

    var name: String
    var health: Int
    var currentHealth: Int
    var weapon: Weapon
    
    
    /// Character's properties
    /// - Parameters:
    ///   - name: character's name given by the player
    ///   - maximumHealth: health point at start of each game
    ///   - currentHealth: tracks current health of the characters
    ///   - weapon: default weapon carried by the character
    init(name: String,maximumHealth: Int, currentHealth: Int, weapon: Weapon) {
        self.name = name
        self.health = maximumHealth
        self.currentHealth = currentHealth
        self.weapon = weapon
    }
    
    
    
    /// Introduce Attack function in this class as common for all characters to attack.
    
    /// Introduce Wizzard healing power here maybe
    
}
