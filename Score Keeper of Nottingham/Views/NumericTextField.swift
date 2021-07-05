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
    @State private var value = "" // Empty will show a 0 placeholder
    let text: String
    
    var body: some View {
        HStack{
            Text(self.text)
            Spacer()
            TextField("0", text: $value)
                .frame(width: 40)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .multilineTextAlignment(.trailing)
                .onReceive(Just(value)) { newValue in
                    let filtered = newValue.filter { "0123456789".contains($0) }
                    if filtered != newValue {
                        self.value = filtered
                    }
                }
        }
        
    }
}

struct NumericTextField_Previews: PreviewProvider {
    static var previews: some View {
        NumericTextField(text: "Chickens:")
    }
}
