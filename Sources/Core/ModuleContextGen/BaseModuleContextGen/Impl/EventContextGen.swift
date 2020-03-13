//
//  EventContextGen.swift
//  
//
//  Created by Alexander Filimonov on 13/03/2020.
//

import PathKit

public final class EventContextGen: ContextGenerator<EventCategory> {

    // MARK: - ContextGenerator

    public override func generate() throws -> FileContext {
        let fileName = baseConfig.language.getFinalName(
            name: "\(input.name)_\(moduleConfig.namingPostfix).\(baseConfig.language.fileExtension)",
            needCapitalizeFirst: true
        )
        return FileContext(
            filePath: moduleConfig.outputFolderPath + Path(fileName),
            templateFilePath: moduleConfig.templateFilePath,
            context: try EventCategoryRawMapper(model: input, moduleConfig: moduleConfig, baseConfig: baseConfig, parameterMapper: parameterMapper).toRaw()
        )
    }

}
