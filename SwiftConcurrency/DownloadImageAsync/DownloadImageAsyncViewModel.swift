//
//  DownloadImageAsyncViewModel.swift
//  SwiftConcurrency
//
//  Created by Karim Ezzedine on 17/02/2023.
//

import SwiftUI
import Combine

class DownloadImageAsyncViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let loader = DownloadImageAsyncImageLoader()
    var cancellables = Set<AnyCancellable>()
    
    func fetchImage() async {
        
//        loader.downloadWithEscaping { [weak self] image, error in
//            DispatchQueue.main.async {
//                self?.image = image
//            }
//        }
        
//        loader.downloadWithCombine()
//            .receive(on: DispatchQueue.main)
//            .sink { _ in
//
//            } receiveValue: { [weak self] image in
//                self?.image = image
//            }
//            .store(in: &cancellables)

        let image = try? await loader.downloadWithAsync()
        await MainActor.run {
            self.image = image
        }
        
    }
    
}
