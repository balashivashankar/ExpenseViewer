//
//  ExpenseRowView.swift
//  ExpenseViewer
//
//  Created by BALA SHIVA SHANKAR TELUGU on 14/12/25.
//

import SwiftUI

// A reusable row view that displays a single expense.
// Used inside a SwiftUI `List`.
struct ExpenseRowView: View {
    // Expense model passed from the parent view
    let expense: Expense
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(expense.title)
                    .font(.headline)
                
                Text(dateString(expense.date))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Text(amountString(expense.amount))
                .font(.body)
        }
        .padding(.vertical, 6)
    }
    // Converts a `Date` into a user-friendly string
    // Example output: "3 July 2021"
    private func dateString(_ date: Date) -> String {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df.string(from: date)
    }
    // Converts a numeric amount into a localized currency string
    // Example output: "₹ 230.50"
    private func amountString(_ value: Double) -> String {
        let n = NumberFormatter()
        n.numberStyle = .currency
        return n.string(from: NSNumber(value: value)) ?? "\(value)"
    }
}
