//
//  Simulator.swift
//  Simulator
//
//  Created by Filip Klembara on 17/02/2020.
//

import FiniteAutomata

/// Errors for automata validation
public enum AutomataError: Error {
    case undefinedState
    case undefinedSymbol
}

/// Simulator
public struct Simulator {
    /// Finite automata used in simulations
    private let finiteAutomata: FiniteAutomata

    /// Initialize simulator with given automata
    /// - Parameter finiteAutomata: finite automata
    public init(finiteAutomata: FiniteAutomata) {
        self.finiteAutomata = finiteAutomata
    }

    /// Simulate automata on given string
    /// - Parameter string: string with symbols separated by ','
    /// - Returns: Empty array if given string is not accepted by automata,
    ///     otherwise array of states
    public func simulate(on string: String) -> [String] {
        // ***************
        // * IMPLEMENTED *
        // ***************
        
        var symbols: [String] = []
        for symbol in string.split(separator: ",") {
            symbols.append(String(symbol))
        }
        
        let result = _simulate(on: symbols, with: finiteAutomata.initialState)
        
        // Return empty array on failure (input not accepted by the autotata)
        return result ?? []
    }
    
    /// Helper recursive function for running simulation
    /// - Parameter symbols: Array of strings representing input symbols
    /// - Parameter state: Current state
    /// - Returns: Array of states that given symbols have transitioned or nil if given symbols are not accepted by the automata
    private func _simulate(on symbols: [String], with state: String) -> [String]? {
        var result: [String] = []
        
        // Ugly stuff going on here :(
        var symbols = symbols
        
        // End of input string
        // Check current state
        if symbols.isEmpty {
            if finiteAutomata.finalStates.contains(state) {
                return [state]
            } else {
                return nil
            }
        }
        
        // Append current state to result, if any error occures nil will be returned instead, invalidating this path
        result.append(state)
        
        let currentSymbol = symbols.removeFirst()
        
        // Symbols in input string are not validated in `validate` function, so doing it here
        if !finiteAutomata.symbols.contains(currentSymbol) {
            return nil
        }
        
        // Check all possible transitions, because the automata is not deterministic
        for transition in finiteAutomata.transitions {
            if transition.from == state && transition.with == currentSymbol {
                if let states = _simulate(on: symbols, with: transition.to) {
                    result.append(contentsOf: states)
                    return result
                }
            }
        }
        
        // No possible path from current state
        return nil
    }
    
    /// Validate if automata is valid (states and symbols)
    /// - Throws: AutomataError.undefinedState and AutomataError.undefinedSymbol
    public func validate() throws {
        // Initial state must be in states
        if (!finiteAutomata.states.contains(finiteAutomata.initialState)) {
            throw AutomataError.undefinedState
        }
        
        // Final states have to be in states
        for state in finiteAutomata.finalStates {
            if (!finiteAutomata.states.contains(state)) {
                throw AutomataError.undefinedState
            }
        }
        
        // Transitions' states `from` and `to` have to be in states
        // and symbol `with` has to be in symbols
        for transition in finiteAutomata.transitions {
            if !finiteAutomata.states.contains(transition.from) {
                throw AutomataError.undefinedState
            }
            if !finiteAutomata.states.contains(transition.to) {
                throw AutomataError.undefinedState
            }
            if !finiteAutomata.symbols.contains(transition.with) {
                throw AutomataError.undefinedSymbol
            }
        }
    }
}
