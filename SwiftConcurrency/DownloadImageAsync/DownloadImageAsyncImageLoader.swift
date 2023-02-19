//
//  DownloadImageAsyncImageLoader.swift
//  SwiftConcurrency
//
//  Created by Karim Ezzedine on 17/02/2023.
//

import SwiftUI
import Combine

class DownloadImageAsyncImageLoader {
    
    let url = URL(string: "https:/picsum.photos/200")
    
    func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard let data = data,
              let image = UIImage(data: data),
              let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
        else { return nil }
        
        return image
    }
    
    //MARK: - Download With Escaping
    
    func downloadWithEscaping(completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        
        guard let url = url, UIApplication.shared.canOpenURL(url) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            let image = self?.handleResponse(data: data, response: response)
            completionHandler(image, error)
        }
        .resume()
    }
    
    //MARK: - Download With Combine
    
//        func downloadWithCombine() -> AnyPublisher<UIImage?, Error> {
//            guard let url = url, UIApplication.shared.canOpenURL(url) else {
//                return Fail(error: NSError(domain: "Invalid URL", code: 0, userInfo: nil))
//                    .eraseToAnyPublisher()
//            }
//
//            return URLSession.shared.dataTaskPublisher(for: url)
//                .tryMap { data, response in
//                    guard let image = UIImage(data: data) else {
//                        throw NSError(domain: "Invalid Image Data", code: 0, userInfo: nil)
//                    }
//                    return image
//                }
//                .mapError { error -> Error in
//                    if let urlError = error as? URLError {
//                        return urlError
//                    } else {
//                        return NSError(domain: "Unknown Error", code: 0, userInfo: nil)
//                    }
//                }
//                .eraseToAnyPublisher()
//        }
    
    func downloadWithCombine() -> AnyPublisher<UIImage?, Error> {
        
        guard let url = url, UIApplication.shared.canOpenURL(url) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(handleResponse)
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }
    

    //MARK: - Download With Async
    
    func downloadWithAsync() async throws -> UIImage? {
        
        guard let url = url, await UIApplication.shared.canOpenURL(url) else {
            return nil
        }
         
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            return handleResponse(data: data, response: response)
        }
        catch {
            throw error
        }
        
    }
    
}
