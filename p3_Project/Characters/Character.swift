//
//  Character.swift
//  p3_Project
//
//  Created by Birkyboy on 14/03/2021.
//

import Foundation


/// This class defines the companions properties and abilities
class Character {
    
    var name: String
    var icon: String
    var life: Int
    var canHeal: Bool
    var weapon: Weapon
    
    
    /// Character's properties
    /// - Parameters:
    ///   - name: companion's name given by the player
    ///   - life: tracks current Life of the companions
    ///   - weapon: default weapon carried by the companion
    init(name: String, icon: String, life: Int, canHeal: Bool, weapon: Weapon) {
        self.name = name
        self.icon = icon
        self.life = life
        self.canHeal = canHeal
        self.weapon = weapon
    }
    
    
 
    // MARK: - Characters abilities
    
    /// attacks enemies function
    /// reduces eneny's life by weapon damage point
    /// - Parameter enemy: pass in character to attack
    func fight(_ character: Character) {
        character.life -= weapon.damage
        
        /// if enemy's current Life equate 0 or less
        /// set currentLife at 0
        /// inform player character dead
        if character.life <= 0 {
            character.life = 0
            print("""

            ----------------------------------------
            \(character.icon) \(character.name) is ⚰️ DEAD !
            ----------------------------------------

            """)
        } else {
            print("\(character.icon) \(character.name) life is down to \(character.life) points.\n")
        }
    }
    
    
    /// heal character function
    /// - Parameter character: pass in character to heal
    func heal(_ character: Character) {
            character.life += weapon.healingPower
            
            /// limit life to go over 100
            if character.life > 100 {
                character.life = 100
            }
                print("""

                ---------------------------------
                🧬 Your Life is now \(character.life)! 🧬
                ---------------------------------
                """)
    }
    
    
    
}
