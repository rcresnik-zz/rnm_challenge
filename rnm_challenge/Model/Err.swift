//
//  Err.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import Foundation

struct Err: Error {
    var description: String

    init<T>(sender: T, error: Error) {
        let name = String(describing: sender.self)

        if let error = error as? DecodingError {
            self.description = ""
            switch error {
            case .typeMismatch(_, let log):
                self.description = createErrorDescription(name: name, log: log)
            case .valueNotFound(_, let log):
                self.description = createErrorDescription(name: name, log: log)
            case .keyNotFound(_, let log):
                self.description = name + " " + log.debugDescription
            case .dataCorrupted(let log1):
                print(log1)
            }
        } else {
            self.description = ""
        }
    }

    private func createErrorDescription(name: String, log: DecodingError.Context) -> String {
        let lastLog = log.codingPath.last.debugDescription
        if let results = lastLog.range(of: "\"([^\"]+)\"", options: .regularExpression) {
            let part = lastLog[results]

            return name + "." + part + ": " + log.debugDescription
        }
        return name + " " + log.debugDescription
    }
}
