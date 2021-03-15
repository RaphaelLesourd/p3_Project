//
//  Game.swift
//  p3_Project
//
//  Created by Birkyboy on 13/03/2021.
//

import Foundation

/*
 - Instantiate 2 players
 - Create teams
 
 */


class Game {
    

    let playerOne = Player(playerNumber: 1)
    let playerTwo = Player(playerNumber: 2)
    
    
    func start() {
        playerOne.createTeam()
        playerTwo.createTeam()
        
    }
    
    
    
    
  
    
    
}
