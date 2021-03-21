//
//  main.swift
//  proj1
//
//  Created by Filip Klembara on 17/02/2020.
//

import Foundation
import FiniteAutomata
import Simulator

// MARK: - Main
func main() -> Result<Void, RunError> {
    // ***************
    // * IMPLEMENTED *
    // ***************
    
    if CommandLine.arguments.capacity != 3 {
        return .failure(.invalidArguments)
    }
    
    let inputSymbols = CommandLine.arguments[1]
    let automataPath = NSString(string: CommandLine.arguments[2]).expandingTildeInPath
    
    guard let file: FileHandle = FileHandle(forReadingAtPath: automataPath) else {
        return .failure(.fileHandlingError)
    }
    
    let fileData = file.readDataToEndOfFile()
    file.closeFile()
    
    do {
        let automata = try JSONDecoder().decode(FiniteAutomata.self, from: fileData)
        
        let simulator = Simulator(finiteAutomata: automata)
        try simulator.validate()
        
        let states = simulator.simulate(on: inputSymbols)
        if states.isEmpty {
            return .failure(.inputNotAccepted)
        }
        for state in states {
            print(state)
        }
    }
    catch AutomataError.undefinedState {
        return .failure(.undefinedState)
    }
    catch AutomataError.undefinedSymbol {
        return .failure(.undefinedSymbol)
    }
    catch {
        return .failure(.automataDecodingError)
    }
    
    return .success(Void())
}

// MARK: - program body
let result = main()

switch result {
case .success:
    break
case .failure(let error):
    var stderr = STDERRStream()
    print("Error:", error.description, to: &stderr)
    exit(Int32(error.code))
}
