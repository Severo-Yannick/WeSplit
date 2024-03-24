//
//  ContentView.swift
//  WeSplit
//
//  Created by Yannick Severo on 11/03/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipePercentage = 20
    @FocusState private var amountIsFocused: Bool
    let tipePercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let typeSelection = Double(tipePercentage)
        
        let typeValue = amount / 100 * typeSelection
        let grandTotal = amount + typeValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section{
                    TextField("Enter your amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0)")
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section("How much do you want to tipe ?") {
                    Picker("Tipe Percentages", selection: $tipePercentage) {
                        ForEach(tipePercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                }
            }
            .navigationTitle("WeSplit").opacity(0.8)
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
        
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
