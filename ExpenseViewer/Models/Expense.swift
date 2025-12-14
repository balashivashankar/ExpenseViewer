//
//  Expense.swift
//  ExpenseViewer
//
//  Created by BALA SHIVA SHANKAR TELUGU on 14/12/25.
//

import Foundation

// Model representing a single expense item.
// This is a plain data model used across the app.
struct Expense: Identifiable {
    let id: String
    let title: String
    let amount: Double
    let date: Date
}
