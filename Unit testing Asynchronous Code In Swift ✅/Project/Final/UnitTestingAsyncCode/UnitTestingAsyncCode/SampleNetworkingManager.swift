//
//  SampleNetworkingManager.swift
//  UnitTestingAsyncCode
//
//  Created by Tunde Adegoroye on 25/01/2023.
//

import Foundation

enum MyError: Error {
    case custom
}

class SampleNetworkingManager {
    
    var time: Int!
    var isSuccessfull: Bool!
    
    init() {}
    
    @available(*, renamed: "getData()")
    func getData(completion: @escaping (Result<String, MyError>) -> ()) {
        Task {
            do {
                let result = try await getData()
                completion(.success(result))
            } catch {
                completion(.failure(error as! MyError))
            }
        }
    }
    
    
    func getData() async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(time)) {
                if self.isSuccessfull {
                    continuation.resume(returning: "Data Here")
                } else {
                    continuation.resume(throwing: MyError.custom)
                }
            }
        }
    }
}
