//
//  APICaller.swift
//  MonteKristTest
//
//  Created by Artur Imanbaev on 08.08.2023.
//

import Foundation
enum CustomError: Error{
    case invalidUrl
    case invalidData
}
final class APICaller{
    static let shared = APICaller()
    private init (){
        
    }
    func request<T: Codable>(
        url: URL?,
        expecting: T.Type,
        completion: @escaping(Result<T,Error>) -> Void
    ){
        guard let url = url else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                if let error = error{
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            do{
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
