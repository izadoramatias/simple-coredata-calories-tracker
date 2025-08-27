//
//  ContentView.swift
//  CoreDataTest
//
//  Created by Izadora Matias on 27/08/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
    
    @State private var isShowingAddView = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("\(Int(totalCaloriesToday())) Kcal (Today)")
                    .foregroundStyle(.gray)
                    .padding(.horizontal)
                
                List {
                    ForEach(food) { food in
                        NavigationLink(destination: EditFoodView(food: food)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(food.name!)
                                        .bold()
                                    
                                    Text("\(Int(food.calories))")
                                    +
                                    Text(" calories")
                                        .foregroundStyle(.red)
                                }
                                
                                Spacer()
                                
                                Text(TimeFormatting.calcTimeSince(date: food.date!))
                                    .foregroundStyle(.gray)
                                    .italic()
                            }
                        }
                    }
                    .onDelete(perform: deleteFood)
                }
                .listStyle(.plain)
            }
            .navigationTitle("CaloriesCounter")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingAddView.toggle()
                    } label: {
                        Label("Add food", systemImage: "plus.circle")
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $isShowingAddView) {
                AddFoodView()
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private func deleteFood(offsets: IndexSet) {
        withAnimation {
            offsets.map { food[$0] }
                .forEach(managedObjectContext.delete)
            
            DataController().save(context: managedObjectContext)
        }
    }
    
    private func totalCaloriesToday() -> Double {
        var totalCalories: Double = 0
        
        for item in food {
            if Calendar.current.isDateInToday(item.date!) { totalCalories += item.calories }
        }
        
        return totalCalories
    }
}

#Preview {
    ContentView()
}
