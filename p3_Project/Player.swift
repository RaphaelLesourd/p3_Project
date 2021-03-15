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
        while team.count < maxTeamCharacters {
           presentCharacterChoiceMenu()
            
        }
    }
    
    
    private func presentCharacterChoiceMenu() {
        
        // - Present Menu with all 4 characters choice and that characteristics
        // - Wait for user input
        // - add character to team
        
        print("""
            Player \(playerNumber), please choose \(maxTeamCharacters - team.count)  characters to join your team:
            1. Colossus has \(Colossus.maximumHealth) pts health, uses a \(Colossus.weapon.name) giving \(Colossus.weapon.damage) point damages
            2. Dwarf has \(Dwarf.maximumHealth) pts health, uses a \(Dwarf.weapon.name) giving \(Dwarf.weapon.damage) point damages
            3. Warrior has \(Warrior.maximumHealth) pts health, uses a \(Warrior.weapon.name) giving \(Warrior.weapon.damage) point damages
            4. 🧙🏽‍♂️ Wizzard can heal your team mates with his \(Wizzard.wand.name)
            
            """)
         
    }
    
   
    
    /// Request user input for character's name
   private func characterNameRequest() -> String {
        if let input = readLine() {
            if !input.isEmpty, !charactersNameExist(for: input) {
                return input
            }
        }
       return characterNameRequest()
    }
    
    /// check is character with same name already exists in the team
   private func charactersNameExist(for name: String) -> Bool {
        if team.contains(where: {$0.name == name}) {
            return true
        }
        return false
    }
}
