//
//  SampleNetworkingManager.swift
//  UnitTestingAsyncCode
//
//  Created by Tunde Adegoroye on 25/01/2023.
//

import Foundation

class SampleNetworkingManager {
    
    var time: Int!
    var isSuccessfull: Bool!
    
    init() {}
    
    func getData(completion: @escaping (Bool) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(time)) {
            completion(self.isSuccessfull)
        }
    }
}
