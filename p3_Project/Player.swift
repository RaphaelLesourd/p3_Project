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
/// - Selecter a companion to add to the team


class Player: Equatable {
    
    /// Class conforms to Equatable protocol so current player and enemy's player can be compared to swap turn
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.playerNumber == rhs.playerNumber 
    }

    /// max number of companions in team
    private let maxTeamCompanions = 3
    
    /// Player's id
    var playerNumber: Int
    /// array storing all companions in player's team
    var team = [Companion]()
    
    /// Instantiate a player
    /// - Parameter playerNumber: either player 1 or player 2
    init(playerNumber: Int) {
        self.playerNumber = playerNumber
    }
    
    // MARK: - Team creation
    
    /// Create player's team flow
    ///     - Display Intro message
    ///     - Present Choice of companions
    ///     - Await for player choice
    ///     - Prompt to give a name
    ///     - Add player to team
    func createTeam() {
        
        print("*** 👩‍👦 PLAYER \(playerNumber) Create your team ***")

        displayCompanionChoiceMenu()
        
        print("Please select \(maxTeamCompanions) companions to join your team:")
        
        
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
                        print("✅ Team complete, well done!\n")
                    } else {
                        print("👨‍👨‍👦‍👦 Team count \(team.count) - Select \(maxTeamCompanions - (team.count)) more:")
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
    
    
     func displayTeam() {
    
        guard team.count != 0 else {
            print("🪦 All Dead ! ⚰️")
            return
        }
        
        //enumarate team array to display remaining companions
        for (index, companion) in team.enumerated() {
            
            var weaponStrength = String()
            /// Check if character is wizzard
            /// success case : display weapon healing power
            /// fail case : display weapon damage power
            if let chosenCharacter = companion as? Wizzard {
                weaponStrength = "\(chosenCharacter.weapon.healingPower)"
            } else {
                weaponStrength = "\(companion.weapon.damage)"
            }
            print("\(index + 1). \(companion.icon) \(companion.name.uppercased()). ❤️ Life: \(companion.currentLife) ---- 🥊 Weapon: \(companion.weapon.name) \(weaponStrength) ")
        }
    }
    
    
    
    
    /// Player selects his companion from his team or enemys from other team
    /// - Parameter team: pass in team which character is selected from
    /// - Returns: return selected charater
     func selectFighters(from team: [Companion]) -> Companion {
        /// Prompt player to make a choice
        if let playerChoice = readLine() {
            /// convert string to Int
            /// check if player choice is valid by comparing input to team count
        
            if let index = Int(playerChoice), index <= team.count {
                /// if choice is valid return companion
                let chosenCompanion = team[index - 1]
                return chosenCompanion
            }
            /// if choice not valid inform player and return to selection
            print("oups! this choice does not exist")
        }
        return selectFighters(from: team)
    }
   
    
    /// func checking if wizzard on is present
    /// to perfom in game class a check if  both team have wizzard.
    /// the game would finish to prevent no win situation as wizzard dont attack
    /// - Returns: true/false statement if only wizzard remain
    func onlyWizzardInTeamCheck() -> Bool {
        return team.count == 1 && team.first is Wizzard
    }


// MARK: - Name Request

    
    /// Request user input for character's name
    /// return name if not empty and not in the team already
    private func companionNameRequest() -> String {
        /// Prompt player to give a name
        print("💭 Choose a name for this character:")
        
        /// Check is input is empty and if name already exits in the team
        if let input = readLine() {
            if !input.isEmpty, !companionNameExist(for: input) {
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
    private func companionNameExist(for name: String) -> Bool {
        if team.contains(where: {$0.name == name}) {
            return true
        }
        return false
    }
}
