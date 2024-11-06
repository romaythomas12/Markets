//
//  NetworkClientTests.swift
//  Interview
//
//  Created by Thomas Romay on 06/11/2024.
//  Copyright © 2024 AJBell. All rights reserved.
//

import Foundation
@testable import Interview
import XCTest

final class NetworkClientTests: XCTestCase {
    func testPerformNetworkRequestSuccess() async throws {
        let mockSession = MockNetworkSession(mockData: mockData,
                                             mockResponse: HTTPURLResponse(url: URL(string: "https://example.com")!,
                                                                           statusCode: 200,
                                                                           httpVersion: nil,
                                                                           headerFields: nil))

        let networkClient = MarketRemoteAPIService(session: mockSession)

        let data = try await networkClient.fetchMarkets()
        XCTAssertEqual(data.count, 3)
    }

    func testPerformNetworkRequestFailure() async throws {
        let mockSession = MockNetworkSession(mockData: mockData,
                                             mockResponse: HTTPURLResponse(url: URL(string: "https://example.com")!,
                                                                           statusCode: 404,
                                                                           httpVersion: nil,
                                                                           headerFields: nil))

        let networkClient = MarketRemoteAPIService(session: mockSession)
        
        do {
            let _ = try await networkClient.fetchMarkets()
            XCTFail("Expected an error to be thrown, but got data instead.")
        } catch let error as URLError {
            XCTAssertEqual(error, URLError(.badServerResponse))
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
       
    }
}

let mockData = """
{
    "data": [
        {
            "CompanyName": "Apple Inc.",
            "Epic": "AAPL",
            "CurrentPrice": "149.50"
        },
        {
            "CompanyName": "Tesla Inc.",
            "Epic": "TSLA",
            "CurrentPrice": "732.00"
        },
        {
            "CompanyName": "Amazon.com Inc.",
            "Epic": "AMZN",
            "CurrentPrice": "3202.50"
        }
    ]
}

""".data(using: .utf8)!
