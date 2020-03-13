//
//  Progress.swift
//  
//
//  Created by Alexander Filimonov on 13/03/2020.
//

import Foundation
import Basic
import SPMUtility

final class Progress {

    // MARK: - Constants

    private enum Constants {
        static let defaultProgressWidth = 50
    }

    // MARK: - Private Properties

    private let allItems: Int
    private var currentItem: Int = 0
    private var currentProgressInPercents: Int {
        return Int(Float(currentItem) / Float(allItems) * 100.0)
    }
    private let tc = TerminalController(stream: stdoutStream)

    // MARK: - Initialization

    init(allItems: Int) {
        self.allItems = allItems

        tc?.endLine()
        printProgress()
    }

    // MARK: - Methods

    func next() {
        currentItem += 1
//        Thread.sleep(forTimeInterval: 1)
        printProgress()
    }

}

// MARK: - Private Methods

private extension Progress {

    func printProgress() {
        tc?.clearLine()
        tc?.write("progress \(currentProgressInPercents)% : [")
        for j in 0...Constants.defaultProgressWidth {
            if j <= currentProgressInPercents / (100 / Constants.defaultProgressWidth) {
                tc?.write("-")
            } else {
                tc?.write(".")
            }
        }
        tc?.write("]")
    }

}
