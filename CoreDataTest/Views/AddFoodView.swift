//
//  AddFoodView.swift
//  CoreDataTest
//
//  Created by Izadora Matias on 27/08/25.
//

import SwiftUI

struct AddFoodView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var caloriesString: String = ""
    @State private var caloriesDouble: Double = 0
    @State private var isShowingInvalidField: Bool = false
    
    var body: some View {
        Form {
            Section {
                TextField("Food name", text: $name)
                TextField("Calories", text: $caloriesString)
                    .keyboardType(.decimalPad)
                    .onChange(of: caloriesString) { _, newValue in
                        if let convertedValue = Double(newValue) {
                            caloriesDouble = convertedValue
                        } else {
                            caloriesDouble = 0.0
                        }
                    }
                
                if isShowingInvalidField {
                    Text("'Calories' field can't be empty.")
                        .foregroundStyle(.red)
                        .padding(.top, 5)
                }
                
                HStack {
                    Spacer()
                    Button("Submit") {
                        
                        guard let _ = Double(caloriesString),
                            caloriesString.isEmpty == false else {
                            isShowingInvalidField = true
                            return
                        }
                        
                        if isShowingInvalidField { isShowingInvalidField.toggle() }
                        
                        DataController().addFood(
                            name: name,
                            calories: caloriesDouble,
                            context: managedObjectContext
                        )
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    AddFoodView()
}
