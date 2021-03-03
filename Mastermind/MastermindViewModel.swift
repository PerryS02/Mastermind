//
//  MastermindViewModel.swift
//  Mastermind
//
//  Created by Perry Sykes on 2/21/21.
//

import Foundation

class MastermindGame: ObservableObject {
    @Published private var mastermindGame: Mastermind<PegColor> = MastermindGame.createMastermindGame()
    
    struct PegColor: Identifiable {
        var id: Int
        var RGB: Array<Double>
    }
    
    //createMastermindGame
    //  initialize 7 PegColor structs, each with a unique id
    //  initialize 'pegColors' as array of PegColors, containing all PegColors except for 'empty'
    //  initialize 'randomCode' as empty array of PegColor
    //  make 4 random PegColors from elements of pegColors
    //  then append them to 'randomCode'
    //  insert the 'empty' PegColor at the front of 'pegColors'
    //  return Mastermind, sending in 'pegColors' and 'randomCode'
    private static func createMastermindGame() -> Mastermind<PegColor> {
        print("Making New Game")
        let empty: PegColor = PegColor(id: 0, RGB:[1.0, 1.0, 1.0])
        let red: PegColor = PegColor(id: 1, RGB: [1.0, 0.0, 0.0])
        let orange: PegColor = PegColor(id: 2, RGB: [1.0, 0.6, 0.0])
        let yellow: PegColor = PegColor(id: 3, RGB: [1.0, 1.0, 0.0])
        let green: PegColor = PegColor(id: 4, RGB: [0.0, 1.0, 0.0])
        let blue: PegColor = PegColor(id: 5, RGB: [0.0, 0.0, 1.0])
        let purple: PegColor = PegColor(id: 6, RGB: [1.0, 0.0, 1.0])
        
        var pegColors: Array<PegColor> = [red, orange, yellow, green, blue, purple]
        
        var randomCode: Array<PegColor> = []
        let randomPeg1: PegColor = pegColors.randomElement()!
        let randomPeg2: PegColor = pegColors.randomElement()!
        let randomPeg3: PegColor = pegColors.randomElement()!
        let randomPeg4: PegColor = pegColors.randomElement()!
        randomCode.append(randomPeg1)
        randomCode.append(randomPeg2)
        randomCode.append(randomPeg3)
        randomCode.append(randomPeg4)
        
        pegColors.insert(empty, at: 0)
        
        return Mastermind(pegColors: pegColors, answer: randomCode)
    }
    // MARK: -Access to the Model
    var guesses: Array<Mastermind<PegColor>.Guess> {
        return mastermindGame.guesses
    }
    // MARK: -Intents
    func fillSlot(pegID: Int) {
        objectWillChange.send()
        mastermindGame.fillSlot(pegID: pegID)
    }
    
    func delete() {
        objectWillChange.send()
        mastermindGame.delete()
    }
    
    func newGame() {
        objectWillChange.send()
        mastermindGame = MastermindGame.createMastermindGame()
    }
}
