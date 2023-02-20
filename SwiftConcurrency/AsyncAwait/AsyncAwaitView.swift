//
//  AsyncAwaitView.swift
//  SwiftConcurrency
//
//  Created by Karim Ezzedine on 20/02/2023.
//

import SwiftUI



struct AsyncAwaitView: View {
    
    @StateObject private var viewModel = AsyncAwaitViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.dataArray, id: \.self) { data in
                Text(data)
            }
        }
        .onAppear {
            
            Task {
                await viewModel.addAuthor1()
                await viewModel.addSomething()
                
                let finalText = "Final Text: \(Thread.current)"
                viewModel.dataArray.append(finalText)
            }
            
//            viewModel.addThread1()
//            viewModel.addThread2()
        }
    }
}

struct AsyncAwaitView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncAwaitView()
    }
}
