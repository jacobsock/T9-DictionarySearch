//
//  DictionaryModel.swift
//  T9-DictionarySearch
//
//  Created by Jacob M Sock  on 1/24/24.
//

//
//  DictonaryModel.swift
//  MobilePhoneAndDictonaryChallenge
//
//  Created by Jacob M Sock  on 1/24/24.
//

import Foundation


class DictonaryModel : ObservableObject {
    
    @Published var rawDict : [String]  = []
    @Published var wordsInRawDict : Int = 0
    @Published var rawDictDownloaded : Bool = false
    
    @Published var threeLetterProcessedDict : [String]  = []
    @Published var wordsInThreeLetterProcessedDict : Int = 0
    @Published var threeLetterProcessedDictDownloaded : Bool = false
    
    @Published var wordsMappedToNumbersDict : [String: Int]  = [:]
    
    @Published var wordsInWordsMappedToNumbersDict : Int = 0
    @Published var wordsMappedToNumbersDictDownloaded : Bool = false
  
    
     var finalArray : [String] = []
    @Published var finalArrayDownloaded : Bool = false
    
    
    
    
    func downloadDict(){
        print("downloadDict")
        if let path = Bundle.main.path(forResource: "raw-dict", ofType: "txt") {
            do {
                print("path created")
                let content = try String(contentsOfFile: path, encoding: .utf8)
                
                // Remove unnecessary characters
                let cleanedContent = content
                    .replacingOccurrences(of: "[", with: "")
                    .replacingOccurrences(of: "]", with: "")
                    .replacingOccurrences(of: "\"", with: "")
                    .replacingOccurrences(of: ":", with: "")
                    .replacingOccurrences(of: "1", with: "")
                    .replacingOccurrences(of: ",", with: "")
                
                
                 self.rawDict = cleanedContent.components(separatedBy: .newlines)
                
                self.rawDict = self.rawDict.map { $0.replacingOccurrences(of: "\\s", with: "", options: .regularExpression) }
                
                print(self.rawDict.count)
                wordsInRawDict =  self.rawDict.count
                rawDictDownloaded = true
                
                
            } catch {
                print("Error reading the file: \(error)")
            }
        } else {
            print("Couldn't create path")
        }
        
        
    }
    
    
    func threeLetterWordsPreProcess(){
        
        
        for word in rawDict {
            if(word.count == 3){
                self.threeLetterProcessedDict.append(word)
            }
        }
        
        
        
        print("three :\(self.threeLetterProcessedDict)")
        self.wordsInThreeLetterProcessedDict = threeLetterProcessedDict.count
        self.threeLetterProcessedDictDownloaded = true
    }
    
    
    func mapThreeLetterWordsToNumbers(){
        
        
        for word in threeLetterProcessedDict{
            
            var numberString = ""
            
            switch word.first{
                
                
            case "a":
                numberString += "2"
            case "b":
                numberString += "2"
            case "c":
                numberString += "2"
                
            case "d":
                numberString += "3"
            case "e":
                numberString += "3"
            case "f":
                numberString += "3"
                
            case "g":
                numberString += "4"
            case "h":
                numberString += "4"
            case "i":
                numberString += "4"
                
            case "j":
                numberString += "5"
            case "k":
                numberString += "5"
            case "l":
                numberString += "5"
                
            case "m":
                numberString += "6"
            case "n":
                numberString += "6"
            case "o":
                numberString += "6"
                
            case "p":
                numberString += "7"
            case "q":
                numberString += "7"
            case "r":
                numberString += "7"
            case "s":
                numberString += "7"
                
            case "t":
                numberString += "8"
            case "u":
                numberString += "8"
            case "v":
                numberString += "8"
                
            case "w":
                numberString += "9"
            case "x":
                numberString += "9"
            case "y":
                numberString += "9"
            case "z":
                numberString += "9"
          
            default:
                print("default")
                
                
            }
            
            
            switch word[word.index(word.startIndex, offsetBy: 1)]{
                
            case "a":
                numberString += "2"
            case "b":
                numberString += "2"
            case "c":
                numberString += "2"
                
            case "d":
                numberString += "3"
            case "e":
                numberString += "3"
            case "f":
                numberString += "3"
                
            case "g":
                numberString += "4"
            case "h":
                numberString += "4"
            case "i":
                numberString += "4"
                
            case "j":
                numberString += "5"
            case "k":
                numberString += "5"
            case "l":
                numberString += "5"
                
            case "m":
                numberString += "6"
            case "n":
                numberString += "6"
            case "o":
                numberString += "6"
                
            case "p":
                numberString += "7"
            case "q":
                numberString += "7"
            case "r":
                numberString += "7"
            case "s":
                numberString += "7"
                
            case "t":
                numberString += "8"
            case "u":
                numberString += "8"
            case "v":
                numberString += "8"
                
            case "w":
                numberString += "9"
            case "x":
                numberString += "9"
            case "y":
                numberString += "9"
            case "z":
                numberString += "9"
          
            default:
                print("default")
                
                
            }
            
            switch word.last{
                
                
            case "a":
                numberString += "2"
            case "b":
                numberString += "2"
            case "c":
                numberString += "2"
                
            case "d":
                numberString += "3"
            case "e":
                numberString += "3"
            case "f":
                numberString += "3"
                
            case "g":
                numberString += "4"
            case "h":
                numberString += "4"
            case "i":
                numberString += "4"
                
            case "j":
                numberString += "5"
            case "k":
                numberString += "5"
            case "l":
                numberString += "5"
                
            case "m":
                numberString += "6"
            case "n":
                numberString += "6"
            case "o":
                numberString += "6"
                
            case "p":
                numberString += "7"
            case "q":
                numberString += "7"
            case "r":
                numberString += "7"
            case "s":
                numberString += "7"
                
            case "t":
                numberString += "8"
            case "u":
                numberString += "8"
            case "v":
                numberString += "8"
                
            case "w":
                numberString += "9"
            case "x":
                numberString += "9"
            case "y":
                numberString += "9"
            case "z":
                numberString += "9"
          
            default:
                print("default")
                
                
            }
            
            let numberValue = Int(numberString)!
            
            wordsMappedToNumbersDict[word] = numberValue
            
            wordsInWordsMappedToNumbersDict = wordsMappedToNumbersDict.count
            wordsMappedToNumbersDictDownloaded = true
            
        }
        print(wordsMappedToNumbersDict)
    }
    
    
    func determineAllWords(number: Int){
        
            // Iterate over the dictionary
            for (word, value) in wordsMappedToNumbersDict {
                // Check if the value matches the given number
                if value == number {
                    // Add the word to the final array
                    self.finalArray.append(word)
                }
            }
        
        print(finalArray)
        finalArrayDownloaded = true
        
        
    }
    
}
    

