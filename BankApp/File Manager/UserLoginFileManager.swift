//
//  UserLoginFileManager.swift
//  BankApp
//
//  Created by Ziyadkhan on 06.03.24.
//

import Foundation

class UserLoginFileManager {
    
    func getFilePath() -> URL {
        let files = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let path = files[0].appendingPathComponent("usersLoginData.json")
        print(path)
        return path
    }
    
    func writeUserData(users: [UserModel]) {
        do {
            let data = try JSONEncoder().encode(users)
            try data.write(to: getFilePath())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func readUserData(complete: (([UserModel]) -> Void)) {
        if let data = try? Data(contentsOf: getFilePath()) {
            do {
                let items = try JSONDecoder().decode([UserModel].self, from: data)
                complete(items)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

