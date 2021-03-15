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
    
    /// player number  1 or 2
    var playerNumber: Int
    
    /// array storing all characters in player's team
    var team = [Character]()
  
    init(playerNumber: Int) {
        self.playerNumber = playerNumber
    }
    
    
    // What each player have to do:
    
    // - Create a team : - choose 3 characters
    //                   - give it a name ***
    //                   - add each character to the team array ***
    
    
    func createTeam() {
        while team.count < maxTeamCharacters {
           characterChoiceMenu()
            
        }
    }
    
    
    private func characterChoiceMenu() {
        
        // - Present Menu with all 4 characters choice and that characteristics
        // - Wait for user input
        // - add character to team
        
        print("""
            Player \(playerNumber), please choose \(maxTeamCharacters - team.count)  characters to join your team:

            

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
