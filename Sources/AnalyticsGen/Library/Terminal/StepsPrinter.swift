//
//  File.swift
//  
//
//  Created by Alexander Filimonov on 26/05/2020.
//

import Foundation
import Basic

final class StepsPrinter {

    // MARK: - Private Properties

    private let tc: TerminalController?
    private let color: TerminalController.Color
    private let stepsCount: Int
    private var currenStep = 0

    // MARK: - Initializaion

    init(tc: TerminalController?,
         color: TerminalController.Color,
         stepsCount: Int) {
        self.tc = tc
        self.color = color
        self.stepsCount = stepsCount
    }

    // MARK: - Methods

    func add(_ step: String) {
        tc?.write("[\(currenStep)/\(stepsCount)] ", inColor: color)
        tc?.write(step, inColor: color)
        tc?.endLine()
        currenStep += 1
    }

    func clear() {
        currenStep = 0
    }

}
