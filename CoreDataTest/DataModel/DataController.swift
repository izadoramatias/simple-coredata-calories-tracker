//
//  DataController.swift
//  CoreDataTest
//
//  Created by Izadora Matias on 27/08/25.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "FoodModel")
    
    init () {
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        guard let _ = try? context.save() else {
            print("We could not save the data...")
            return
        }
        
        print("Data saved!!! Woohoo!!!")
    }
    
    func addFood(name: String, calories: Double, context: NSManagedObjectContext) {
        let food = Food(context: context)
        food.id = UUID()
        food.date = Date()
        food.name = name
        food.calories = calories
        
        save(context: context)
    }
    
    func editFood(food: Food, name: String, calories: Double, context: NSManagedObjectContext) {
        food.date = Date()
        food.name = name
        food.calories = calories
        
        save(context: context)
    }
}
