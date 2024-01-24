//
//  ContentView.swift
//  T9-DictionarySearch
//
//  Created by Jacob M Sock  on 1/24/24.
import SwiftUI

struct ContentView: View {
    
    @ObservedObject var dictModel = DictonaryModel()
    @State private var numberInput: String = ""
    var body: some View {
        VStack {
            
            if(dictModel.rawDictDownloaded){
                
                
                VStack{
                    
                    
                    
                    
                    
                    if(!dictModel.threeLetterProcessedDictDownloaded){
                        Text("Awesome! You completed the first step. \n You now have a digital dictionary with 370,100 words contained in it. This is quite a lot. For this challenge, we are only concered with 3 letter words. Let's do some pre-processing on the digital dictonary so it only contains 3 letter words, greatly reducing our input size which will improve runtime efficency")
                        Button(action: {
                            print("pre-process to 3 pressed!")
                            dictModel.threeLetterWordsPreProcess()
                            
                        }, label: {
                            Text("Pre-process raw digital dictonary to only contain words with 3 letters")
                        })
                        
                    }else{
                        if(!dictModel.wordsMappedToNumbersDictDownloaded){
                            Text("Awesome! You completed the second step. \n You now have a digital dictionary with only 2,130  words contained in it compared to 370,100 This is quite an improvement. \n \n Since we need to use this digital dictonary to look up words based on a numeric code from the digital mobile phone emulator. Is there another pre-processing operation we can perform? \n\n Let's try pre-process our small dictionary so each word is mapped to a numeric code for faster lookup.")
                            Button(action: {
                                print("map each word in dictionary to 3 digit pressed")
                                //dictModel.threeLetterWordsPreProcess()
                                dictModel.mapThreeLetterWordsToNumbers()
                                
                            }, label: {
                                Text("map each word in dictionary to 3 digit int")
                            })
                            
                        }else{
                            
                            if(!dictModel.finalArrayDownloaded){
                                Text("Awesome! You completed the third step. \n You now have a digital dictionary with 2,130 mapped to a numeric code.")
                                
                                TextField("Enter Number", text: $numberInput)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                
                                Button(action: {
                                    print("determine all words for number called")
                                    if let number = Int(numberInput) {
                                        dictModel.determineAllWords(number: number)
                                        
                
                                    } else {
                                        // Handle invalid input (non-numeric)
                                        print("Invalid input. Please enter a valid number.")
                                    }
                                    
                                    
                                    
                                }, label: {
                                    Text("Determine all words for number \(numberInput)")
                                })
                                
                            }else{
                                Text("Awesome!")
                                
                                if(dictModel.finalArray.isEmpty){
                                    Text("No words for the input \(numberInput)")
                                }else{
                                    VStack{
                                        Text("\(dictModel.finalArray.count) words for the input \(numberInput)")
                                        HStack{
                                            ForEach(dictModel.finalArray, id: \.self){ word in
                                                
                                                Text("\(word)")
                                            }
                                            
                                        }
                                    }
                                    
                                }
                            }
                            
                            
                            
                            
                        }
                        
                        
                        
                        
                    }
                    
                    
                }
                
                
                
                
                
            }else{
                Text("Welcome to your interview\n")
                
                Text("You arrive at your first software engineering job interview and your interviewer supplies you with a digital mobile phone emulator and digital dictonary. \n \n")
                
                HStack{
                    
                    Image(systemName: "book")
                    
                    Image(systemName: "phone")
                }
                
                Text("The interviewer wants you to write a algorithm, that when given a random 3 digit sequence, such as 687, it returns all the possible words that are able to be created with that sequence via the old mobile phone using T-9 (our,mus,mts,nus). \n \n Note: The provided digital dictonary will contain abbreivations such as 'mus,mts,nus' it is completely valid for your solution to contain those as well, for this exercise you do not need to excluded them \n \n They encourage  you to pre process the dictionary in order to reduce the input size for your final algorithm, and expalin that when they test your solution with random 3 number sequences the runtime must be at most O(n)\n\n")
                                                                                                                
                                                                                                                Spacer()
                
                
                Button(action: {
                    print("download raw dict pressed!")
                    dictModel.downloadDict()
                    
                }, label: {
                    Text("Download Raw Digital Dictonary from Bundle")
                })
                
            }
            
            
            
            Spacer()
            if(dictModel.rawDictDownloaded){
                Text("Words in raw digital Dictionary: \(dictModel.wordsInRawDict) ")
            }else{
                Text("Please download the raw digital dictonary to get started!")
            }
            
            if(dictModel.threeLetterProcessedDictDownloaded){
                Text("Words in pre-processed digital Dictionary containing only 3 letters: \(dictModel.wordsInThreeLetterProcessedDict) ")
            }
            
            if(dictModel.wordsMappedToNumbersDictDownloaded){
                Text("Words successfully mapped to number: \(dictModel.wordsInWordsMappedToNumbersDict) ")
            }
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
