//
//  AsyncAwaitViewModel.swift
//  SwiftConcurrency
//
//  Created by Karim Ezzedine on 20/02/2023.
//

import Foundation

class AsyncAwaitViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func addThread1() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.dataArray.append("Thread 1: \(Thread.current)")
        }
    }
    
    func addThread2() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) { [weak self] in
            let thread = "Thread 2: \(Thread.current)"

            DispatchQueue.main.async {
                self?.dataArray.append(thread)

                let thread3 = "Thread 3: \(Thread.current)"
                self?.dataArray.append(thread3)
            }
        }
    }
    
    func addAuthor1() async {
        
        await MainActor.run {
            let author1 = "Author 1: \(Thread.current)"
            dataArray.append(author1)
        }
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        let author2 = "Author 2: \(Thread.current)"
        await MainActor.run(body: {
            dataArray.append(author2)
            
            let author3 = "Author 3: \(Thread.current)"
            dataArray.append(author3)
        })
        
    }
    
    func addSomething() async {
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        let something1 = "Something 1: \(Thread.current)"
   
        await MainActor.run(body: {
            dataArray.append(something1)
            
            let something2 = "Something 2: \(Thread.current)"
            dataArray.append(something2)
        })
    }
    
}
