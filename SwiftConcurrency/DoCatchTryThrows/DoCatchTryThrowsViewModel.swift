//
//  DoCatchTryThrowsViewModel.swift
//  SwiftConcurencyBootcamp
//
//  Created by Karim Ezzedine on 14/02/2023.
//

import Foundation

class DoCatchTryThrowsViewModel: ObservableObject {
    
    @Published var text: String = "Starting text."
    let manager = DoCatchTryThrowsDataManager()
    
    func fetchTitle() {
       
        /*
        let result = manager.getTitle()
        
        switch result {
        case .success(let newTitle):
            self.text = newTitle
        case .failure(let error):
            self.text = error.localizedDescription
        }
        */
        
        /*let newTitle = try? manager.getTitle2()
        if let newTitle = newTitle {
            self.text = newTitle
        }
        */
        
        do {
            
            /*let newTitle = try manager.getTitle2()
            self.text = newTitle*/
            
            let newTitle = try? manager.getTitle2()
            if let newTitle = newTitle {
                self.text = newTitle
            }

            let finalTitle = try manager.getTitle3()
            self.text = finalTitle
        } catch {
            self.text = error.localizedDescription
        }
        
    }
}
