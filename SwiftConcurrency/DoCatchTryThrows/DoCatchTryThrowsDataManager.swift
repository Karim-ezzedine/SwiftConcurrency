//
//  DoCatchTryThrowsDataManager.swift
//  SwiftConcurencyBootcamp
//
//  Created by Karim Ezzedine on 14/02/2023.
//

import Foundation

class DoCatchTryThrowsDataManager {
    
    let isActive: Bool = true
    
    func getTitle() -> Result<String, Error> {
        if isActive {
            return .success("New Text!")
        }
        else {
            return .failure(URLError(.appTransportSecurityRequiresSecureConnection))
        }
    }
    
    func getTitle2() throws -> String {
        if !isActive {
            return "New Text!"
        }
        else {
            throw URLError(.badServerResponse)
        }
    }
    
    func getTitle3() throws -> String {
        if isActive {
            return "Final Text!"
        }
        else {
            throw URLError(.badServerResponse)
        }
    }
    
}
