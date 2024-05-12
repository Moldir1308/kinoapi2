//
//  Service.swift
//  Api2
//
//  Created by Ualikhan Sabden on 05.11.2023.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    func fetchJsonData(urlString: String, completion: @escaping (MoviesResult?, Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        
        request.setValue("api_key", forHTTPHeaderField: "2c175bb0c2861f443af58f1865608112")
                request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
                request.setValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyYzE3NWJiMGMyODYxZjQ0M2FmNThmMTg2NTYwODExMiIsInN1YiI6IjY1NTlkNzE4ZWE4NGM3MTA5NTlmODcwMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.UmK2UNgJ939JtLit63baWDgxwiguN1b5KRZiNLdxzOk", forHTTPHeaderField: "Authorization")
        
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            
            if let err = err {
                completion(nil, err)
                return
            }
            
            do {
                let objects = try JSONDecoder().decode(MoviesResult.self, from: data!)
                completion(objects,nil)
            } catch {
                completion(nil, error)
                print("Failed to decode:",error)
            }
            }.resume()
    }
    
}
