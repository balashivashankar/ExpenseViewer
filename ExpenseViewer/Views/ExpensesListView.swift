//
//  ExpensesListView.swift
//  ExpenseViewer
//
//  Created by BALA SHIVA SHANKAR TELUGU on 14/12/25.
//

import SwiftUI

// Main screen that displays a list of expenses.
// Acts as the View layer in MVVM.
struct ExpensesListView: View {
    // ViewModel owned by this view.
    // `@StateObject` ensures the ViewModel is created once
    // and survives SwiftUI view redraws.
    @StateObject private var vm = ExpensesViewModel()
    var body: some View {
        // Navigation container for title and future navigation
        NavigationView {
            ZStack {
                // List automatically renders rows for each expense
                List(vm.expenses) { expense in
                    ExpenseRowView(expense: expense)
                }
                .navigationTitle("Expenses")
                .refreshable { vm.loadExpenses() }
                if vm.isLoading {
                    ProgressView("Loading...")
                }
            }
        }
        // Trigger data loading when the view first appears
        .onAppear {
            vm.loadExpenses()
        }
    }
}
