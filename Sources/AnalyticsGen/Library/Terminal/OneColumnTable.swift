//
//  File.swift
//  
//
//  Created by Alexander Filimonov on 26/05/2020.
//

import Foundation
import SPMUtility
import Basic

final class OneColumnTable {

    // MARK: - Nested Types

    enum RowPosition {
        case first, middle, last

        // MARK: - Properties

        var firstSymbol: String {
            switch self {
            case .first:
                return "┌"
            case .middle:
                return "├"
            case .last:
                return "└"
            }
        }

        var lastSymbol: String {
            switch self {
            case .first:
                return "┐"
            case .middle:
                return "┤"
            case .last:
                return "┘"
            }
        }

    }

    struct Row {

        // MARK: - Nested Types

        enum Alignment {
            case left, center, right
        }

        // MARK: - Properties

        let lines: [String]
        let color: TerminalController.Color
        let isBold: Bool
        let alignment: Alignment

        // MARK: - Initializaion

        init(strings: [String],
             color: TerminalController.Color = .white,
             isBold: Bool = false,
             alignment: Alignment = .left) {
            self.lines = strings
            self.color = color
            self.isBold = isBold
            self.alignment = alignment
        }

        init(string: String,
             color: TerminalController.Color = .white,
             isBold: Bool = false,
             alignment: Alignment = .left) {
            self.init(strings: [string],
                      color: color,
                      isBold: isBold,
                      alignment: alignment)
        }

    }

    // MARK: - Private Properties

    private let tc: TerminalController?
    private let width: Int
    private let color: TerminalController.Color

    private var rows: [Row] = []

    // MARK: - Initializaion

    init(tc: TerminalController?,
         width: Int,
         color: TerminalController.Color) {
        self.tc = tc
        self.width = width
        self.color = color
    }

    // MARK: - Methods

    @discardableResult
    func clear() -> Self {
        rows.removeAll()
        return self
    }

    @discardableResult
    func add(_ row: Row) -> Self {
        rows.append(row)
        return self
    }

    @discardableResult
    func add(_ rows: [Row]) -> Self {
        self.rows.append(contentsOf: rows)
        return self
    }

    func render() {
        for (index, row) in rows.enumerated() {
            let isFirst = index == 0
            let isLast = index == rows.count - 1

            writeSeparator(rowPosition: isFirst ? .first : .middle)
            for line in row.lines {
                writeString(string: line, stringColor: row.color, stringIsBold: row.isBold, alignment: row.alignment)
            }
            if isLast {
                writeSeparator(rowPosition: .last)
            }
        }
    }

}

// MARK: - Private Properties

private extension OneColumnTable {

    func writeString(string: String,
                     stringColor: TerminalController.Color,
                     stringIsBold: Bool,
                     alignment: Row.Alignment) {
        tc?.write("|", inColor: color)
        defer {
            tc?.write("|", inColor: color)
            tc?.endLine()
        }
        guard string.count <= width - 2 else {
            tc?.write(String(string.prefix(width - 5)) + "...", inColor: stringColor, bold: stringIsBold)
            return
        }
        let diffBetweenWidths = width - 2 - string.count
        switch alignment {
        case .left:
            tc?.write(string, inColor: stringColor, bold: stringIsBold)
            repeatString(" ", count: diffBetweenWidths)
        case .center:
            let afterOffset = diffBetweenWidths / 2
            let beforeOffset = diffBetweenWidths - afterOffset
            repeatString(" ", count: beforeOffset)
            tc?.write(string, inColor: stringColor, bold: stringIsBold)
            repeatString(" ", count: afterOffset)
        case .right:
            repeatString(" ", count: diffBetweenWidths)
            tc?.write(string, inColor: stringColor, bold: stringIsBold)
        }
    }

    func writeSeparator(rowPosition: RowPosition) {
        tc?.write(rowPosition.firstSymbol, inColor: color)
        for _ in 0..<(width - 2) {
            tc?.write("-", inColor: color)
        }
        tc?.write(rowPosition.lastSymbol, inColor: color)
        tc?.endLine()
    }

    func repeatString(_ string: String, count: Int) {
        for _ in 0..<count {
            tc?.write(string, inColor: color)
        }
    }

}
