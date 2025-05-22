//
//  LoanViewModel.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 22/5/25.
//

import Foundation
import SwiftUI

class LoanViewModel: ObservableObject {
    
    @Published var loanTypes: LoanTypeModel?
    @Published var loanTypeIndex: Int = 0
    @Published var indexSelected = -1
    
    func loadJSON<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename): \(error)")
        }
    }
}
