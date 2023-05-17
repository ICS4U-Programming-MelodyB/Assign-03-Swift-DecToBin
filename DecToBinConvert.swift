// This program will read information from an input file
// it will then use recursion to convert the decimal to 
// binary

//
// Created by Melody Berhane

// Created on 2023-05-10

// Version 1.0

//  Copyright (c) 2023 Melody. All rights reserved.
import Foundation

// Define input & output paths.
let inputFile = "input.txt"
let outputFile = "output.txt"

// Usage of file handle method to locate files,
// as well as opening input for file reading.
do {
    // Open input file for reading.
    guard let input = FileHandle(forReadingAtPath: inputFile) else {
        print("Error: cannot access input file for opening.")
        exit(1)
    }

    // Open output file for writing.
    guard let output = FileHandle(forWritingAtPath: outputFile) else {
        print("Error: cannot access output file for opening.")
        exit(1)
    }

    // Read context for file.
    let inputData = input.readDataToEndOfFile()

    // Convert data to a string.
    guard let inputString = String(data: inputData, encoding: .utf8) else {
        print("Error: Cannot convert input data to string.")
        exit(1)
    }

    // Split string into lines, ensuring reading empty line.
    let inputLines = inputString.components(separatedBy: .newlines)

    // Usage of loop to access each element.
    for str in inputLines {
        if let num = Int(str) { 
            // Call function.
            let binary = DecToBin(decNumber: num)
            // Converts the binary into a string.
            var numberString = String(binary)
            // Checks if the length of the string is less than 8.
            // If it is, then it will add 0 to the left.
            while numberString.count % 8 != 0 {
                numberString = "0" + numberString
            }
            var spacedNumbers = ""
            // It will look at how long the string is and add
            // a space after 4 characters.
            for (index, character) in numberString.enumerated() {
                spacedNumbers += String(character)
                if (index + 1) % 4 == 0 {
                    spacedNumbers += " "
                }
            }

            let data1 = Data(("The binary of " + str ).utf8)
            output.write(data1)
            let data2 = Data((" is " + String(spacedNumbers) + "\n").utf8)
            output.write(data2)
        } else {
            // Display error if input is not acceptable
            let data3 = Data(("Please enter a valid input." + "\n" ).utf8)
            output.write(data3)
        }

    }

    // Close input & output file.
    input.closeFile()
    output.closeFile()

}

// This function uses recursion to
// convert Decimals to Binary.
func DecToBin(decNumber: Int) -> Int {
    // Converts the decimal number to binary.
    if decNumber == 0 {
        return 0
    } else {
        return (decNumber % 2) + 10 * DecToBin(decNumber: decNumber / 2)
    }
}