//
//  ContentView.swift
//  T9-DictionarySearch
//
//  Created by Jacob M Sock  on 1/24/24.
import SwiftUI

struct ContentView: View {
    
    @ObservedObject var dictModel = DictonaryModel()
    @State private var numberInput: String = ""
    @State private var resetBool = false
    @State private var onboardingComplete = false
    @State private var showLengthAlert = false
    @State private var showInvalidInputAlert = false
    @State private var alertTriggered = false
    var body: some View {
        
        if(onboardingComplete){
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
                                Text("Awesome! \n \n You completed the second step. \n\n You now have a digital dictionary with only 2,130  words contained in it compared to 370,100. \n \n This is quite an improvement. \n \n Since we need to use this digital dictonary to look up words based on a 3 digit T-9 numeric code produced from the digital mobile phone emulator. Is there another pre-processing operation we can perform? \n\n Let's try pre-process our small dictionary so each word is mapped to a numeric code for faster lookup.")
                                Button(action: {
                                    print("map each word in dictionary to 3 digit pressed")
                                    //dictModel.threeLetterWordsPreProcess()
                                    dictModel.mapThreeLetterWordsToNumbers()
                                    
                                }, label: {
                                    Text("map each word in dictionary to 3 digit int")
                                })
                                
                            }else{
                                
                                if(!dictModel.finalArrayDownloaded){
                                    
                                    if(!resetBool){
                                        VStack{
                                            Text("Awesome! You completed the third step. \n You now have a digital dictionary with 2,130 words mapped each mapped to a 3 digit T-9 numeric code. For example, 'cab':222")}
                                        
                                        Text("Number Input: \(numberInput)")
                                        
                                    }
                                    
                                    else{
                                        VStack{
                                            Text("You already created your digital dictonary with words mapped to a 3 digit T-9 numeric code, so it is ready for use! No need to pre-process again.")
                                            
                                            Text("Number Input: \(numberInput)")
                                        }
                                        }
                                    
                                    
                                    
//                                    TextField("Enter Number", text: $numberInput)
//                                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                                        .padding()
                                    
                                    KeypadView(numberInput: $numberInput, showLengthAlert: $showLengthAlert, showInvalidInputAlert: $showInvalidInputAlert, alertTriggered: $alertTriggered)
                                    
                                    
                                    
                                    
                                    Button(action: {
                                        print("determine all words for number called")
                                        
                                        if(numberInput.count == 3){
                                            if let number = Int(numberInput) {
                                                
                                                
                                                dictModel.determineAllWords(number: number)
                                                
                                                
                                            } else {
                                                // Handle invalid input (non-numeric)
                                                print("Invalid input. Please enter a valid number.")
                                            }
                                        }
                                       
                                        
                                        
                                        
                                    }, label: {
                                        Text("Determine all words for number \(numberInput)")
                                    })
                                    
                                }else{
                                    
                                    
                                    if(dictModel.finalArray.isEmpty){
                                        Text("Try a different 3 digit T-9 input")
                                        Text("No words for the input \(numberInput)")
                                    }else{
                                        Text("Awesome!")
                                        VStack{
                                            Text("\(dictModel.finalArray.count) words for the input \(numberInput)")
                                            HStack{
                                                ForEach(dictModel.finalArray, id: \.self){ word in
                                                    
                                                    Text("\(word)")
                                                }
                                                
                                            }
                                        }
                                        
                                    }
                                    
                                    Button(action: {
                                        
                                        dictModel.finalArray.removeAll()
                                        dictModel.finalArrayDownloaded = false
                                        numberInput = ""
                                        
                                    }, label: {
                                        Text("New 3 digit T-9 Search")
                                    })
                                    
                                    Button(action: {
                                        
                                        dictModel.rawDict.removeAll()
                                        dictModel.wordsInRawDict = 0
                                        dictModel.rawDictDownloaded = false
                                        
                                        dictModel.threeLetterProcessedDict = []
                                        dictModel.wordsInThreeLetterProcessedDict = 0
                                        dictModel.threeLetterProcessedDictDownloaded = false
                                        
                                        dictModel.wordsMappedToNumbersDict = [:]
                                        dictModel.wordsInWordsMappedToNumbersDict = 0
                                        dictModel.wordsMappedToNumbersDictDownloaded = false
                                        
                                        dictModel.finalArray.removeAll()
                                        dictModel.finalArrayDownloaded = false
                                        numberInput = ""
                                        
                                    }, label: {
                                        Text("Reset Tutorial")
                                    })
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
                    
                    Text("The interviewer wants you to write an algorithm, that when given a random 3 digit sequence, such as 687, it returns all the possible words that are able to be created with that sequence via the digital mobile phone simulator using T-9 inputs. For the input 687, the expected result is: our,mus,mts,nus. \n \n Note: The provided digital dictonary will contain abbreivations such as 'mus,mts,nus' it is completely valid for your solution to contain those as well, for this exercise you do not need to excluded them \n \n They encourage  you to pre-process the dictionary in order to reduce the input size for your final algorithm, and explain that when they test your solution with random 3 number sequences the runtime must be at most O(n).\n\n")
                    
                    Spacer()
                    Text("Please download the raw digital dictonary to get started!")
                    
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
                }
                
                if(dictModel.threeLetterProcessedDictDownloaded){
                    Text("Words in pre-processed digital Dictionary containing only 3 letters: \(dictModel.wordsInThreeLetterProcessedDict) ")
                }
                
                if(dictModel.wordsMappedToNumbersDictDownloaded){
                    Text("Words successfully mapped to number: \(dictModel.wordsInWordsMappedToNumbersDict) ")
                }
            }
            .padding()
        
    
            .alert(isPresented: $alertTriggered) {
                if showLengthAlert {
                    return Alert(
                        title: Text("Cannot exceed 3 digits"),
                        message: Text("Please delete a digit if need be"),
                        dismissButton: .default(Text("OK")) {
                                       // Reset showLengthAlert when dismissed
                                       showLengthAlert = false
                                   }
                    )
                } else if showInvalidInputAlert {
                    return Alert(
                        title: Text("Invalid input"),
                        message: Text("Please only use digits 2-9."),
                        dismissButton: .default(Text("OK")) {
                                       // Reset showLengthAlert when dismissed
                            showInvalidInputAlert = false
                                   }
                    )
                } else {
                    return Alert(title: Text(""))
                }
            }

        }
        else {
            Text("This app will take you through a mock interview question and the steps you could potentially take to reach an algorithmic solution, specifically focused on pre-processing.\n\n First, run through the app to understand the overall algorthim works. \n\n Next, before throughly analyzing my source code, I encourage you to attempt to come up with your own solution, and see if you can determine how to properly pre-process the provided raw-dict.txt file. \n\n Finally, check out my source code to futher understand how I implemented my solution -- any feedback or suggestions are appreciated!")
            
            Button(action: {
                onboardingComplete = true
                
                
            }, label: {
                Text("Get Started")
            })
        }
        
        
    }
}


#Preview {
    ContentView()
}




