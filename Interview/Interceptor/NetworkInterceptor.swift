//
//  NetworkInterceptor.swift
//  Interview
//
//  Created by Tiago on 14/10/2021.
//  Copyright © 2021 AJBell. All rights reserved.
//

import Foundation


class NetworkInterceptor: URLProtocol {
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        
        guard let data = readLocalFile(forName: "markets") else {
            fatalError(
                "No mock response for \(request.url!). This should never happen. Check " +
                "the implementation of `canInit(with request: URLRequest) -> Bool`"
            )
        }
        
        
        let response: Result<Data, Error> = .success(data)
        
        // Simulate the response on a background thread.
        DispatchQueue.global(qos: .default).async {
            switch response {
                case let .success(data):
                    // Simulate received data.
                    self.client?.urlProtocol(self, didLoad: data)
                    
                    // Finish loading (required).
                    self.client?.urlProtocolDidFinishLoading(self)
                    
                case let .failure(error):
                    // Simulate error.
                    self.client?.urlProtocol(self, didFailWithError: error)
            }
        }
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    override func stopLoading() {}
    
}
