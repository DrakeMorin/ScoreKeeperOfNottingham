//
//  NumericTextField.swift
//  Score Keeper of Nottingham
//
//  Created by Drake Morin on 2020-09-04.
//  Copyright © 2020 Drake Morin. All rights reserved.
//

import SwiftUI
import Combine

struct NumericTextField: View {
    
    @Binding var value: Int
    let text: String
    
    var body: some View {
        HStack{
            Text(self.text)
            Spacer()
            TextField("0", text: Binding(
                get: { String(value) },
                set: { value = Int($0.filter { "0123456789".contains($0) }) ?? 0 }
            ))
            .frame(width: 40)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.numberPad)
            .multilineTextAlignment(.trailing)
            .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification)) { obj in
                if let textField = obj.object as? UITextField {
                    // this is implicitly depends on Apple's implementation of a SwiftUI TextField. Could be fragile.
                    textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
                }
            }
        }
        
    }
}

//struct NumericTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        NumericTextField(text: "Chickens:")
//    }
//}
