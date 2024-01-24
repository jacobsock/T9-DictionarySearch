import SwiftUI

struct KeypadView: View {
    let keypadButtons: [[String]] = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["*", "0", "#"]
    ]
    
    let lettersUnderNumbers: [[String]] = [
        ["", "abc", "def"],
        ["ghi", "jkl", "mno"],
        ["pqrs", "tuv", "wxyz"],
        ["", "", ""]
    ]
    
    @Binding var numberInput: String
    @Binding  var showLengthAlert : Bool
    @Binding  var showInvalidInputAlert :Bool
    @Binding var alertTriggered : Bool
    var isActive: Bool
    var condensed : Bool = false
    var body: some View {
        VStack{
            //  Text("Number Input : \(numberInput)")
            VStack(spacing: 10) {
                ForEach(0..<keypadButtons.count, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(0..<keypadButtons[row].count, id: \.self) { col in
                            VStack(spacing: 5) {
                                Button(action: {
                                    if keypadButtons[row][col] == "1" {
                                        print("invalid")
                                        if(isActive){
                                            showInvalidInputAlert = true
                                            alertTriggered = true
                                        }
                                    } else if keypadButtons[row][col] == "*" {
                                        print("invalid")
                                        if(isActive){
                                            showInvalidInputAlert = true
                                            alertTriggered = true
                                        }
                                    } else if keypadButtons[row][col] == "#" {
                                        print("invalid")
                                        if(isActive){
                                            showInvalidInputAlert = true
                                            alertTriggered = true
                                        }
                                    }
                                    else if keypadButtons[row][col] == "0" {
                                        print("invalid")
                                        if(isActive){
                                            showInvalidInputAlert = true
                                            alertTriggered = true
                                        }
                                    }
                                    else {
                                        if(isActive){
                                            print("valid")
                                            if numberInput.count < 3 {
                                                print("adding")
                                                numberInput += keypadButtons[row][col]
                                            } else {
                                                // alert user it is full
                                                print("full")
                                                showLengthAlert = true
                                                alertTriggered = true
                                            }
                                        }
                                        
                                    }
                                }) {
                                    
                                    if(condensed){
                                        ZStack {
                                            VStack{
                                                Text(keypadButtons[row][col])
                                                    .font(.subheadline)
                                                    .foregroundColor(.white)
                                                
                                                Text(lettersUnderNumbers[row][col])
                                                    .font(.caption)
                                                    .foregroundColor(.white)
                                            }
                                        } .frame(width: 30, height: 30)
                                            .background(Color.blue)
                                            .cornerRadius(0)
                                        
                                    }else{
                                        
                                        ZStack {
                                            VStack{
                                                Text(keypadButtons[row][col])
                                                    .font(.title)
                                                    .foregroundColor(.white)
                                                
                                                Text(lettersUnderNumbers[row][col])
                                                    .font(.subheadline)
                                                    .foregroundColor(.white)
                                            }
                                        } .frame(width: 60, height: 60)
                                            .background(Color.blue)
                                            .cornerRadius(10)
                                        
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            .background(.black)
            .cornerRadius(10)
            
            if(!condensed){
                Button {
                    if(isActive && numberInput != ""){
                        numberInput.removeLast()
                    }
                } label: {
                    Text("delete digit")    .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .font(.headline)
                        .cornerRadius(10)
                }
                
            }
        }
        
        
        
    }
}

struct KeypadView_Previews: PreviewProvider {
    static var previews: some View {
        KeypadView(numberInput: .constant(""), showLengthAlert: .constant(false), showInvalidInputAlert: .constant(false), alertTriggered: .constant(false), isActive: true)
    }
}
