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
    @State private var textOpacity = 0.0
    var body: some View {
        
        if(onboardingComplete){
            VStack {
                
                
                
                if(dictModel.rawDictDownloaded){
                    
                    
                    VStack{
                        
                        
                        
                        
                        
                        if(!dictModel.threeLetterProcessedDictDownloaded){
                            VStack{
                                Text("Awesome! \n \n You completed the first step. \n").multilineTextAlignment(.center)
                             
                                Image("dictonary-image").resizable().scaledToFit()
                               
                                Text("You now have a digital dictionary with \(dictModel.wordsInRawDict) words contained in it. \n \n This is quite a lot! \n \n For this challenge, we are only concered with 3 letter words. \n \n Let's do some pre-processing on the digital dictonary so it only contains 3 letter words. \n\n This will greatly reduce our input size which in turn will improve runtime efficency").multilineTextAlignment(.center)
                            }
                            Button(action: {
                                print("pre-process to 3 pressed!")
                                dictModel.threeLetterWordsPreProcess()
                                
                            }, label: {
                                Text("Pre-process digital dictonary to only contain words with 3 letters")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .cornerRadius(10)
                            })
                            
                        }else{
                            if(!dictModel.wordsMappedToNumbersDictDownloaded){
                                Text("Way to go! \n \n You completed the second step. \n").multilineTextAlignment(.center)
                              
                                ZStack{
                                    Image("dictonary-image").resizable().scaledToFit()
                                    Text("Only contains 3 letter words!")
                                        .rotationEffect(.degrees(-45))
                                        .offset(CGSize(width: 100.0, height: -60.0))
                                        .opacity(textOpacity)
                                        .animation(.easeIn(duration: 1.5)) // Adjust duration as needed
                                        .onAppear {
                                            // Set opacity to 1 when the view appears
                                            withAnimation {
                                                textOpacity = 1
                                            }
                                        }
                                        .onDisappear{
                                            textOpacity = 0.0
                                        }

                                }
                                Text("You now have a digital dictionary with only \(dictModel.wordsInThreeLetterProcessedDict) words contained in it compared to 370,100. \n \n This is quite an improvement! \n \n We need to use this dictonary to look up words based on a 3 digit T-9 numeric code. \n\n Let's further pre-process our dictionary so each word is mapped to a numeric code for faster lookup.").multilineTextAlignment(.center)
                                
                                Button(action: {
                                    print("map each word in dictionary to 3 digit pressed")
                                    //dictModel.threeLetterWordsPreProcess()
                                    dictModel.mapThreeLetterWordsToNumbers()
                                    
                                }, label: {
                                    Text("Map each word in the dictionary to a 3 digit integer")
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .font(.headline)
                                        .cornerRadius(10)
                                })
                                
                            }else{
                                
                                if(!dictModel.finalArrayDownloaded){
                                    
                                    if(!resetBool){
                                        VStack{
                                            Text("Fantastic! You completed the final pre processing step.").multilineTextAlignment(.center)
                                         
                                    
                                                Image("dictonary-image").resizable().scaledToFit()
                                            
                                
                                            Text("You now have a digital dictionary with 2,130 words mapped each mapped to a 3 digit T-9 numeric code.\n For example, \(Text("'cab':222").bold())").multilineTextAlignment(.center)}
                                        
                                        Text("\n \(Text("Inputed Number:").bold()) \(numberInput)")
                                        
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
                                    
                                    KeypadView(numberInput: $numberInput, showLengthAlert: $showLengthAlert, showInvalidInputAlert: $showInvalidInputAlert, alertTriggered: $alertTriggered, isActive: true)
                                    
                                    
                                    
                                    
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
                                        Text("Determine all words for number: \(numberInput)")    .padding()
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .font(.headline)
                                            .cornerRadius(10)
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
                                        Text("New 3 digit T-9 Search")    .padding()
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .font(.headline)
                                            .cornerRadius(10)
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
                                        Text("Reset Tutorial")    .padding()
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .font(.headline)
                                            .cornerRadius(10)
                                    })
                                }
                                
                                
                                
                                
                            }
                            
                            
                            
                            
                        }
                        
                        
                    }
                    
                    
                    
                    
                    
                }else{
                    Text("Welcome to Your Mock Interview 🌟\n").font(.title).multilineTextAlignment(.center)

                    Text("Your interviewer provides you with:\n1) Digital mobile phone emulator📱\n2) A digital dictionary in which all words are stored in an array as strings. 📖")
                        .font(.body)


                    HStack{
                    
                    //Image(systemName: "phone")
                        KeypadView(numberInput: .constant(""), showLengthAlert: .constant(false), showInvalidInputAlert: .constant(false), alertTriggered: .constant(false), isActive: false, condensed: true)
                        Image("dictonary-image").resizable().scaledToFit()
                    }
                    VStack{
                        Text("(The instructions scroll)").font(.footnote)
                        Text("Your Instructions:")
                      
                    }
                    ScrollView{
                        Text("Write an algorithm that, given a random 3-digit sequence (e.g., 687), returns all possible words that can be created using the T-9 inputs on the digital mobile phone emulator (digits 0-9 representing possible characters a-z). \n \n For example for an input of 687, the expected result is: \(Text("our").bold()), \(Text("mus").bold()), \(Text("mts").bold()), \(Text("nus").bold()).\n\n \(Text("Note:").bold())The provided dictionary will contain abbreviations like '\(Text("mus").bold()), \(Text("mts").bold()), \(Text("nus").bold()),' it's valid for your solution to include them. \n\n\(Text("Your challenge:").bold()) Pre-process the dictionary to reduce input size for your final algorithm.  \n The runtime for testing with random 3-number sequences must be at most O(n).\n")
                        
                    }

                    Spacer()

                    Text("Ready to start? Download the raw digital dictionary to proceed!").multilineTextAlignment(.center)


                    Button(action: {
                        print("Download Raw Dictionary Pressed!")
                        dictModel.downloadDict()
                    }, label: {
                        Text("Download Raw Digital Dictionary from Bundle")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .font(.headline)
                            .cornerRadius(10)
                    })

                }
                
                
                
                
                
                Spacer()
              
                
    
                
               
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
            VStack{
            Text("Welcome to my Mock Interview Prep App! 🚀").multilineTextAlignment(.center)
            Text("This app will guide you through a mock interview questions. \n \nThe current one is specifically focused on pre-processing data in order to create more efficient algorithmic solutions.\n\n You will be learning how to find all the possible 3 letter words you can create from a 3 digit T-9 input code from a mobile emulator. \n \n First, take a walkthrough of the app to grasp the overall algorithm. \n\n Next, before diving into the source code, try  implementing a solution of your own. See if you can effectively pre-process the provided raw-dict.txt file provided in the project as demonstrated in the tutorial.\n\nFinally, please free to explore my source code for insights into my implementation. Your feedback and suggestions are highly appreciated!").padding()
            
            Button(action: {
                onboardingComplete = true
            }, label: {
                Text("Start Tutorial")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .font(.headline)
                    .cornerRadius(10)
            })
        }

        }
        
        
    }
}


#Preview {
    ContentView()
}




