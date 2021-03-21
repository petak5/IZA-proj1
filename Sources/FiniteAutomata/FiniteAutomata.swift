//
//  FiniteAutomata.swift
//  FiniteAutomata
//
//  Created by Filip Klembara on 17/02/2020.
//

/// Finite automata
public struct FiniteAutomata: Decodable {
    // ***************
    // * IMPLEMENTED *
    // ***************
    public var states: [String]
    public var symbols: [String]
    public var transitions: [Transitions]
    public var initialState: String
    public var finalStates: [String]
}

public struct Transitions: Decodable {
    public var with: String
    public var to: String
    public var from: String
}
