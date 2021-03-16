//
//  Player.swift
//  p3_Project
//
//  Created by Birkyboy on 14/03/2021.
//

import Foundation

/// This class contains all properties of each players:
/// - Player number 1 or 2
/// - Player's team array
///
/// Player's functions:
/// - Create team
/// - Display team


class Player {
    
    /// max number of companions in team
    let maxTeamCompanions = 3
    
    /// Player's id
    var playerNumber: Int
    /// array storing all companions in player's team
    var team = [Companion]()
    
    /// Instantiate a player
    /// - Parameter playerNumber: either player 1 or player 2
    init(playerNumber: Int) {
        self.playerNumber = playerNumber
    }
    
    
    /// Create player's team flow
    ///     - Display Intro message
    ///     - Present Choice of companions
    ///     - Await for player choice
    ///     - Prompt to give a name
    ///     - Add player to team
    func createTeam() {
        print("""

        *** 👩‍👦 PLAYER \(playerNumber) Create your team ***

        Please select \(maxTeamCompanions) companions to join your team:
        """)
        displayCompanionChoiceMenu()
        
        /// while loop requesting companion until team contains maxTeamCompanions (3)
        while team.count < maxTeamCompanions {
            
            let menuChoices = "1234"
            /// Checks if userChoice input is not empty and part of the menu choices
            if let userChoice = readLine(), menuChoices.contains(userChoice) {
                
                var companion: Companion?
                /// prompt player to give a name to this companion 
                let name = companionNameRequest()
                
                switch userChoice {
                case "1":
                    companion = Colossus(name: name)
                case "2":
                    companion = Dwarf(name: name)
                case "3":
                    companion = Warrior(name: name)
                case "4":
                    companion = Wizzard(name: name)
                default:
                    print("⛔️ This choice doesn't exist")
                }
                
                /// unwrap optional for companion , check if companion  is not nil
                if let companion = companion {
                    
                    /// if not nil add companion  to team
                    team.append(companion)
                    
                    /// Display's Team count
                    /// If team complete , display team companions names
                    if team.count == maxTeamCompanions {
                        print("✅ Team complete, well done!")
                    } else {
                        print("\n👨‍👨‍👦‍👦 Team count \(team.count) - Select \(maxTeamCompanions - (team.count)) more:")
                    }
                }
                
            } else {
                print("⛔️ Oups! I don't understand your choice.")
            }
        }
        
        
    }
    
    // MARK: - Display Info
    
    /// - Menu with all 4 characters choice and their  characteristics
    private func displayCompanionChoiceMenu() {
        print("""
            
            1. \(Colossus.icon) Colossus has \(Colossus.maxLife) pts Life. Uses a \(Colossus.weapon.name) giving \(Colossus.weapon.damage) damage points.
            2. \(Dwarf.icon) Dwarf has \(Dwarf.maxLife) pts Life. Uses a \(Dwarf.weapon.name) giving \(Dwarf.weapon.damage) damage points.
            3. \(Warrior.icon) Warrior has \(Warrior.maxLife) pts Life. Uses a \(Warrior.weapon.name) giving \(Warrior.weapon.damage) damage points.
            4. \(Wizzard.icon) Wizzard has \(Warrior.maxLife) pts Life. Uses a \(Wizzard.wand.name) giving \(Wizzard.wand.healingPower) life points.
            
            """)
    }
    
  
    /// Display all team members.
    /// func public for access during the fight to check who remains in the team
    /// show character Dead if current Life of each characters is at 0,
    public func displayCompanionList() {
        
        var teamCount = 0
        team.forEach { (character) in
            teamCount += 1
            var weaponStrength = String()
            /// Check if character is wizzard
            /// success case : display weapon healing power
            /// fail case : display weapon damage power
            if let chosenCharacter = character as? Wizzard {
                weaponStrength = "(\(chosenCharacter.weapon.healingPower)pts)"
            } else {
                weaponStrength = "(\(character.weapon.damage)pts)"
            }
            
            let aliveStatus = "❤️ Life: \(character.currentLife)/\(character.maxLife) - 🤺 Weapon: \(character.weapon.name) " + weaponStrength
            let deadStatus = "is ☠️ DEAD ☠️"
            
            /// Check characters Life and display dead or alive message with stats
            let status = character.currentLife == 0 ? deadStatus : aliveStatus
            
            print("\(teamCount). \(character.icon) \(character.name.uppercased()) \(status)")
        }
    }
    
    
    // TODO Select fighter
    
    
}


// MARK: - Character Name Request functions
extension Player {
    
    /// Request user input for character's name
    /// return name if not empty and not in the team already
    private func companionNameRequest() -> String {
        /// Prompt player to give a name
        print("💭 Choose a name for this character:")
        
        /// Check is input is empty and if name already exits in the team
        if let input = readLine() {
            if !input.isEmpty, !charactersNameExist(for: input) {
                /// case name not taken: return input
                return input
            }
        }
        /// case name taken: inform user and ask again for name
        print("⛔️ Name already taken !")
        return companionNameRequest()
    }
    
    
    /// check is character with same name already exists in the team
    /// returns  true or false if team already contains name
    private func charactersNameExist(for name: String) -> Bool {
        if team.contains(where: {$0.name == name}) {
            return true
        }
        return false
    }
}
