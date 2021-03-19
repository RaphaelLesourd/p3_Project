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
/// - Selecter a character to add to the team


class Player: Equatable {
    
    /// Class conforms to Equatable protocol so current player and enemy's player can be compared to swap turn
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.playerId == rhs.playerId 
    }

    /// max number of characters in team
    private let maxTeamCharacters = 3
    
    var playerId: Int
    var name = String()
    /// array storing all characters in player's team
    var team = [Character]()
    
    /// Instantiate a player
    /// - Parameter playerNumber: either player 1 or player 2
    init(playerNumber: Int) {
        self.playerId = playerNumber
    }
    
   
    // MARK: - Player name
    
    func setName() {
        print("💭 Hey, Player \(playerId) choose a name for yourself:")
        if let playerName = readLine(), !playerName.isEmpty {
            name = playerName.uppercased()
        } else {
            print("⛔️ You did not give a name for this player\n")
            setName()
        }
    }
    
    
    
    
    // MARK: - Team creation
    
    /// Create player's team flow
    ///     - Display Intro message
    ///     - Present Choice of characters
    ///     - Await for player choice
    ///     - Prompt to give a name
    ///     - Add player to team
    func createTeam() {
        
        print("*** 👩‍👦 Welcome \(name), create your team with \(maxTeamCharacters) characters")

        displayCharacterMenuChoice()
        
        print("Enter your choice choice below:")
        
        
        /// while loop requesting character until team contains maxTeamcharacters (3)
        while team.count < maxTeamCharacters {
            
            let menuAvailableChoices = "1234"
            /// Checks if userChoice input is not empty and part of the menu choices
            if let userChoice = readLine(), menuAvailableChoices.contains(userChoice) {
                
                var character: Character?
                /// prompt player to give a name to this character
                let name = characterNameRequest().uppercased()
                
                switch userChoice {
                case "1":
                    character = Colossus(name: name)
                case "2":
                    character = Dwarf(name: name)
                case "3":
                    character = Warrior(name: name)
                case "4":
                    character = Wizzard(name: name)
                default:
                    print("⛔️ This choice doesn't exist")
                }
                
                /// unwrap optional for character , check if character  is not nil
                if let character = character {
                    
                    /// if not nil add character  to team
                    team.append(character)
                    
                    /// Display's Team count
                    /// If team complete , display team characters names
                    if team.count == maxTeamCharacters {
                        print("✅ Team complete, well done!\n")
                    } else {
                        print("👨‍👨‍👦‍👦 Team count \(team.count) - Select \(maxTeamCharacters - (team.count)) more:")
                    }
                }
                
            } else {
                print("⛔️ Oups! I don't understand your choice.")
            }
        }

    }
    
    // MARK: - Display Info
    
    /// - Menu with all 4 characters choice and their  characteristics
    private func displayCharacterMenuChoice() {
        print("""
            
            1. \(Colossus.icon) Colossus has \(Colossus.life) pts Life. Uses a \(Colossus.weapon.name) giving \(Colossus.weapon.damage) damage points.
            2. \(Dwarf.icon) Dwarf has \(Dwarf.life) pts Life. Uses a \(Dwarf.weapon.name) giving \(Dwarf.weapon.damage) damage points.
            3. \(Warrior.icon) Warrior has \(Warrior.life) pts Life. Uses a \(Warrior.weapon.name) giving \(Warrior.weapon.damage) damage points.
            4. \(Wizzard.icon) Wizzard has \(Warrior.life) pts Life. Uses a \(Wizzard.wand.name) giving \(Wizzard.wand.healingPower) life points.
            
            """)
    }
    
    
     func displayTeam() {
    
        guard team.count != 0 else {
            print("🪦 All Dead ! ⚰️")
            return
        }
        
        //enumarate team array to display remaining characters
        for (index, character) in team.enumerated() {
            
            var weaponStrength = String()
            
            /// Check if character is wizzard
            /// success case : display weapon healing power
            /// fail case : display weapon damage power
            if let chosenCharacter = character as? Wizzard {
                weaponStrength = "\(chosenCharacter.weapon.healingPower)"
            } else {
                weaponStrength = "\(character.weapon.damage)"
            }
            print("\(index + 1). \(character.icon) \(character.name.uppercased()). ❤️ Life: \(character.life)      🥊 Weapon: \(character.weapon.name) \(weaponStrength) ")
        }
    }
    
    
    
    
    /// Player selects his character from his team or enemys from other team
    /// - Parameter team: pass in team which character is selected from
    /// - Returns: return selected charater
     func selectAttacker(from team: [Character]) -> Character {
        /// Prompt player to make a choice
        if let playerChoice = readLine() {
            /// convert string to Int
            /// check if player choice is valid by comparing input to team count
        
            if let index = Int(playerChoice), index <= team.count {
                /// if choice is valid return character
                return team[index - 1]
            }
            /// if choice not valid inform player and return to selection
            print("oups! this choice does not exist")
        }
        return selectAttacker(from: team)
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
    private func characterNameRequest() -> String {
        /// Prompt player to give a name
        print("💭 Choose a name:")
        
        /// Check is input is empty and if name already exits in the team
        if let input = readLine() {
            if !input.isEmpty, !characterNameExist(for: input) {
                /// case name not taken: return input
                return input
            }
        }
        /// case name taken: inform user and ask again for name
        print("⛔️ Name already taken !")
        return characterNameRequest()
    }
    
    
    /// check is character with same name already exists in the team
    /// returns  true or false if team already contains name
    private func characterNameExist(for name: String) -> Bool {
        if team.contains(where: {$0.name == name}) {
            return true
        }
        return false
    }
}
