//
//  main.swift
//  StyleKitSwiftExtractor
//
//  Created by Alsey Coleman Miller on 6/9/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

import Foundation

let inputFileName = "StyleKit.swift"

println("Loading \(inputFileName)")

let styleKitPath = NSFileManager.defaultManager().currentDirectoryPath.stringByAppendingPathComponent(inputFileName)

var loadInputFileError: NSError?

let inputText: String? = NSString(contentsOfFile: styleKitPath, encoding: NSUTF8StringEncoding, error: &loadInputFileError) as? String

if inputText == nil {
    
    println(loadInputFileError!.localizedDescription)
    
    exit(EXIT_FAILURE)
}

println("Generating source code")

var sourceCode = "// This is a generated file, do not edit!\n// Generated by StyleKitSwiftExtractor, see https://github.com/colemancda/StyleKitView\n\n"

println("Extracting Canvas Names from \(inputFileName)")

let canvasNames = ExtractCanvasNames(inputText!)

println("Generating StyleKitView source code")

let styleKitViewSourceCode = GenerateStyleKitViewSourceCode(canvasNames)

sourceCode.appendLine(styleKitViewSourceCode)

let styleKitViewFileName = "StyleKitView.generated.swift"

println("Saving StyleKitView.swift to disk")