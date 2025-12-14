//
//  ExpenseService.swift
//  ExpenseViewer
//
//  Created by BALA SHIVA SHANKAR TELUGU on 14/12/25.
//

import Foundation

class ExpenseService {
    static let shared = ExpenseService()
    private init() {}
    private let url = URL(string: "https://www.jsonkeeper.com/b/DYZJF")!
    func fetchExpenses(completion: @escaping (Result<[Expense], Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            // Handle network or connection error
            if let error = error {
                completion(.failure(error))
                return
            }
            // Ensure server returned some data
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: -1)))
                return
            }
            // Objective-C transformation
            // Transform JSON into NSArray using Objective-C helper
            // This is useful when integrating legacy Obj-C modules.
            guard let array = ExpenseTransformer.transformJSONData(data) else {
                completion(.failure(NSError(domain: "Transformation Failed", code: -2)))
                return
            }
            // Convert NSArray → [Expense]
            var expenses: [Expense] = []
            // Iterate over each NSDictionary (Objective-C style)
            for case let dict as NSDictionary in array {
                // Extract fields from dictionary
                guard
                    let id = dict["id"] as? String,
                    let title = dict["title"] as? String,
                    let amount = dict["amount"] as? NSNumber,
                    let date = dict["date"] as? Date
                else { continue }
                // Create Swift model
                expenses.append(
                    Expense(id: id, title: title, amount: amount.doubleValue, date: date)
                )
            }
            // Sort latest → oldest
            expenses.sort { $0.date > $1.date }
            // Return result
            completion(.success(expenses))
        }.resume()
    }
}
