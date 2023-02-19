//
//  DownloadImageAsyncView.swift
//  SwiftConcurrency
//
//  Created by Karim Ezzedine on 17/02/2023.
//

import SwiftUI

//MARK: - View

struct DownloadImageAsyncView: View {
    
    @StateObject private var viewModel = DownloadImageAsyncViewModel()
    
    var body: some View {
        
        ZStack {
            
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }
            
        }
        .onAppear {
            Task {
                await viewModel.fetchImage()
            }
        }
        
    }
}

//MARK: - PreviewProvider

struct DownloadImageAsyncView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadImageAsyncView()
    }
}
