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
    // *******************
    // * NOT IMPLEMENTED *
    // *******************
    
    if CommandLine.arguments.capacity != 3 {
        return .failure(.invalidArguments)
    }
    
    let inputSymbols = CommandLine.arguments[1]
    let automataPath = NSString(string: CommandLine.arguments[2]).expandingTildeInPath
    
    guard let file: FileHandle = FileHandle(forReadingAtPath: automataPath) else {
        print(automataPath)
        return .failure(.fileHandlingError)
    }
    
    let fileData = file.readDataToEndOfFile()
    file.closeFile()
    
    var automata: FiniteAutomata?
    do {
        try automata = JSONDecoder().decode(FiniteAutomata.self, from: fileData)
    }
    catch {
        return .failure(.automataDecodingError)
    }
    
    if let _automata = automata {
        let simulator = Simulator(finiteAutomata: _automata)
        for state in simulator.simulate(on: inputSymbols) {
            print(state)
        }
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
