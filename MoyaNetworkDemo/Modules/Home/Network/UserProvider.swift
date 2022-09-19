//
//  UserProvider.swift
//  MoyaNetworkDemo
//
//  Created by Ahmed Fathy on 19/09/2022.
//

import Foundation
import Moya

protocol UserNetwork: AnyObject {
    func readUsers() async throws -> [User]
    func createUser(_ user: User)
}

class UserNetworkImplementaion: UserNetwork  {
    
    private let provider = MoyaProvider<UserService>()
    
    func readUsers() async throws -> [User]{
        try await withCheckedThrowingContinuation({ continuation in
            provider.request(.readUsers) { result in
                switch result {
                case .success(let responce):
                    
                    do{
                        let user: [User] = try JSONDecoder().decode([User].self, from: responce.data)
                        continuation.resume(returning: user)
                    }catch{
                        continuation.resume(throwing: ERROR_Types.failToDecodeUser(error))
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    continuation.resume(throwing: ERROR_Types.failureToResponce)
                }
            }
        })
    }
    
    
    func createUser(_ user: User) {
        provider.request(.createUser(user)) { result in
            switch result {
            case .success(let response):
                let newUsers = try! JSONDecoder().decode(User.self, from: response.data)
                print(newUsers)
            case .failure(let error):
                print(error.localizedDescription)
                
                
            }
        }
    }
    
    
    
}


