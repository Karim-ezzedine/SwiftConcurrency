 //
//  DoCatchTryThrowsView.swift
//  SwiftConcurencyBootcamp
//
//  Created by Karim Ezzedine on 14/02/2023.
//

import SwiftUI

// do-catch
// try
// throws


//MARK: - View

struct DoCatchTryThrowsView: View {
    
    @StateObject private var viewModel = DoCatchTryThrowsViewModel()
    
    var body: some View {
        
        ZStack {
            Color.blue
            
            Text(viewModel.text)
                .foregroundColor(.white)
                .font(.title2)
        }
        .frame(width: 300, height: 300)
        .onTapGesture {
            viewModel.fetchTitle()
        }
        
    }
}

//MARK: - PreviewProvider

struct DoCatchTryThrowsView_Previews: PreviewProvider {
    static var previews: some View {
        DoCatchTryThrowsView()
    }
}
