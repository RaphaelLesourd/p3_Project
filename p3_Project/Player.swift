//
//  Player.swift
//  p3_Project
//
//  Created by Birkyboy on 14/03/2021.
//

import Foundation

class Player {
    
    /// max number of characters in team
    let maxTeamCharacters = 3
    var playerNumber: Int
    
    /// array storing all characters in player's team
    var team = [Character]()
    
    /// Instantiate a player
    /// - Parameter playerNumber: either player 1 or player 2
    init(playerNumber: Int) {
        self.playerNumber = playerNumber
    }
    
    // TODO:
    //- Present player choice menu to select character
    // - Create a team : - choose 3 characters
    //                   - give it a name ***
    //                   - add each character to the team array ***
    
    func createTeam() {
        print("""

        *** 👩‍👦 PLAYER \(playerNumber) Create your team ***

        Please choose \(maxTeamCharacters) characters to join your team:
        """)
       
        /// while loop requesting character until team contains maxTeamCharacters (3)
        while team.count < maxTeamCharacters {
            
            displayCharacterChoiceMenu()
            
            let menuChoices = "1234"
            /// Checks if userChoice input is not empty and part of the menu choices
            if let userChoice = readLine(), menuChoices.contains(userChoice) {
                
                var character: Character?
                let name = characterNameRequest()
                
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
                
                /// unwrap optional for character , check if chracter is not nil
                if let character = character {
                    /// if not nil add character to team
                    team.append(character)
                    displayTeamInfo()
                }
                
            } else {
                print("⛔️ Oups! I don't understand your choice.")
            }
        }
    }
    
    /// Display's Team count
    /// If team complete , display team characters names
    private func displayTeamInfo() {
       
        if team.count == maxTeamCharacters {
            print("✅ Team complete, well done!")
            displayTeamMembers()
        } else {
            print("\n👨‍👨‍👦‍👦 Team count \(team.count) - Select \(maxTeamCharacters - (team.count)) more:")
        }
    }
   
    
    /// Display all team members.
    /// func public for access during the fight to check who remains in the team
    /// show character Dead if current health of each characters is at 0,
    public func displayTeamMembers() {
        var teamCount = 0
        team.forEach { (character) in
            teamCount += 1
            let status = character.currentHealth == 0 ? "is ☠️ DEAD ☠️" : "remaining ❤️ Life: \(character.currentHealth) points"
            print("\(teamCount). \(character.icon) \(character.name.uppercased()) \(status)")
        }
    }

   
    /// - Menu with all 4 characters choice and their  characteristics
    private func displayCharacterChoiceMenu() {
        print("""
            
            1. \(Colossus.icon) Colossus has \(Colossus.maximumHealth) pts health, uses a \(Colossus.weapon.name) giving \(Colossus.weapon.damage) point damages
            2. \(Dwarf.icon) Dwarf has \(Dwarf.maximumHealth) pts health, uses a \(Dwarf.weapon.name) giving \(Dwarf.weapon.damage) point damages
            3. \(Warrior.icon) Warrior has \(Warrior.maximumHealth) pts health, uses a \(Warrior.weapon.name) giving \(Warrior.weapon.damage) point damages
            4. \(Wizzard.icon) Wizzard can heal your team mates with his \(Wizzard.wand.name)
            
            """)
    }
    
    
    
    // MARK: - Character Name Request functions
    
    /// Request user input for character's name
    /// return name if not empty and not in the team already
    private func characterNameRequest() -> String {
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
        return characterNameRequest()
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
