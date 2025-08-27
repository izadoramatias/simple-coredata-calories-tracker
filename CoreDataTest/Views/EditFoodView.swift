//
//  EditFoodView.swift
//  CoreDataTest
//
//  Created by Izadora Matias on 27/08/25.
//

import SwiftUI

struct EditFoodView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var caloriesString: String = ""
    @State private var caloriesDouble: Double = 0
    @State private var isShowingInvalidField: Bool = false

    var food: FetchedResults<Food>.Element
    
    var body: some View {
        Form {
            Section {
                TextField("\(food.name!)", text: $name)
                    .onAppear {
                        name = food.name!
                        caloriesString = String(food.calories)
                    }
                
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
                        
                        DataController().editFood(
                            food: food,
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
