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
        // *******************
        // * NOT IMPLEMENTED *
        // *******************
        
        var symbols: [String] = []
        for symbol in string.split(separator: ",") {
            symbols.append(String(symbol))
        }
        
        let result = _simulate(on: symbols, with: finiteAutomata.initialState)
        
        return result ?? []
    }
    
    private func _simulate(on symbols: [String], with state: String) -> [String]? {
        var result: [String] = []
        
        // Ugly stuff going on here :(
        var symbols = symbols
        
        if symbols.isEmpty {
            if finiteAutomata.finalStates.contains(state) {
                return [state]
            } else {
                return nil
            }
        }
        
        result.append(state)
        
        let currentSymbol = symbols.removeFirst()
        
        if !finiteAutomata.symbols.contains(currentSymbol) {
            return nil
        }
        
        for transition in finiteAutomata.transitions {
            if transition.from == state && transition.with == currentSymbol {
                if let states = _simulate(on: symbols, with: transition.to) {
                    result.append(contentsOf: states)
                    return result
                }
            }
        }
        
        
        
        
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
