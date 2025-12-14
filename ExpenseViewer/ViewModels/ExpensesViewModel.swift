//
//  ExpensesViewModel.swift
//  ExpenseViewer
//
//  Created by BALA SHIVA SHANKAR TELUGU on 14/12/25.
//

import Foundation

// ExpensesViewModel responsible for preparing expense data for the UI,acts as a bridge between the View (SwiftUI) and the Service layer.
class ExpensesViewModel: ObservableObject {
    // List of expenses displayed by the UI,any change automatically refreshes SwiftUI views.
    @Published var expenses: [Expense] = []
    // Indicates whether data is currently loading.
    // Used to show/hide a ProgressView.
    @Published var isLoading = false
    // Holds error messages to be displayed or logged.
    @Published var errorMessage: String?
    func loadExpenses() {
        // Notify UI that loading has started
        isLoading = true
        // Request data from the service layer
        ExpenseService.shared.fetchExpenses { [weak self] result in
            // Ensure UI updates occur on the main thread
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let list):
                    self?.expenses = list
                case .failure(let err):
                    self?.errorMessage = err.localizedDescription
                    // Clear existing data to avoid stale UI
                    self?.expenses = []
                }
            }
        }
    }
}
