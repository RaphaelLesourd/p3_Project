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
    var icon: String
    var maximumHealth: Int
    var currentHealth: Int
    var weapon: Weapon
    
    
    /// Character's properties
    /// - Parameters:
    ///   - name: character's name given by the player
    ///   - maximumHealth: health point at start of each game
    ///   - currentHealth: tracks current health of the characters
    ///   - weapon: default weapon carried by the character
    init(name: String, icon: String, maximumHealth: Int, currentHealth: Int, weapon: Weapon) {
        self.name = name
        self.icon = icon
        self.maximumHealth = maximumHealth
        self.currentHealth = currentHealth
        self.weapon = weapon
    }
    
    // MARK: - Characters abilities
    
    
    /// attacks enemies
    /// reduces eneny's currentHealth by weapon damage point
    /// - Parameter enemy: pass in oponent character
    func attack(enemy: Character) {
        enemy.currentHealth -= self.weapon.damage
        
        /// if enemy's current health equate 0 or less
        /// set currentHealth at 0
        /// inform player characters dead
        if enemy.currentHealth <= 0 {
            enemy.currentHealth = 0
            print("\(enemy.icon) \(enemy.name) is DEAD !")
        }
    }
    
    /// heal team members
    /// add wizzard weapon (magic wand) healing points
    /// - Parameter teamPlayer: pass in templayer character
    func heal(teamPlayer: Character) {
        if self.weapon.healingPower > 0 {
            teamPlayer.currentHealth += self.weapon.healingPower
            
            /// if reaches max Heath then current health equate to max health
            if teamPlayer.currentHealth > teamPlayer.maximumHealth {
                teamPlayer.currentHealth = teamPlayer.maximumHealth
                print("Your health is back to full!")
            }
        }
    }
    
   
}
