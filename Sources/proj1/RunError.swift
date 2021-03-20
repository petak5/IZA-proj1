//
//  RunError.swift
//  proj1
//
//  Created by Filip Klembara on 17/02/2020.
//

enum RunError: Error {
    // ***************
    // * IMPLEMENTED *
    // ***************
    case inputNotAccepted
    case invalidArguments
    case fileHandlingError
    case automataDecodingError
    case undefinedState
    case undefinedSymbol
    case otherError
}

// MARK: - Return codes
extension RunError {
    var code: Int {
        switch self {
        
        // ***************
        // * IMPLEMENTED *
        // ***************
        case .inputNotAccepted:
            return 6
        case .invalidArguments:
            return 11
        case .fileHandlingError:
            return 12
        case .automataDecodingError:
            return 20
        case .undefinedState:
            return 21
        case .undefinedSymbol:
            return 22
        case .otherError:
            return 99
        }
    }
}

// MARK:- Description of error
extension RunError: CustomStringConvertible {
    var description: String {
        switch self {
        // ***************
        // * IMPLEMENTED *
        // ***************
        case .inputNotAccepted:
            return "Input string is not accepted by the automata"
        case .invalidArguments:
            return "Invalid arguments"
        case .fileHandlingError:
            return "File handling error"
        case .automataDecodingError:
            return "File handling error"
        case .undefinedState:
            return "Undefined automata state"
        case .undefinedSymbol:
            return "Undefined automata symbol"
        case .otherError:
            return "Other error"
        }
    }
}
