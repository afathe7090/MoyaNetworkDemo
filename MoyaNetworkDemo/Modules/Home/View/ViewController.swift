//
//  ViewController.swift
//  MoyaNetworkDemo
//
//  Created by Ahmed Fathy on 19/09/2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let network: UserNetwork = UserNetworkImplementaion()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        fetchAllUsers()
        creatUser()
    }
    
    
    fileprivate func fetchAllUsers()  {
        Task{
            do{
                let users = try await network.readUsers()
                print(users)
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    fileprivate func creatUser(){
        let mockedUser = User(id: Int(66), name: "Ahmed", username: "", email: "",
                        address: .init(street: "", suite: "", city: "", zipcode: "", geo: .init(lat: "", lng: "")),
                        phone: "", website: "", company: .init(name: "", catchPhrase: "", bs: ""))
        network.createUser(mockedUser)
    }
    
    
    
}

