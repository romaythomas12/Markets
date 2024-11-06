//
//  MockMarketService.swift
//  InterviewTests
//
//  Created by Thomas Romay on 21/10/2024.
//  Copyright © 2024 AJBell. All rights reserved.
//

import Foundation
@testable import Interview

final class MockMarketService: Fetchable {
    let shouldReturnError: Bool
    init(shouldReturnError: Bool = false) {
        self.shouldReturnError = shouldReturnError
    }

    func fetchMarkets() async throws -> [Market] {
        if shouldReturnError {
            throw URLError(.badServerResponse)
        }
        return [
            Market(name: "Test Market 1", epic: "TEST1", price: "100"),
            Market(name: "Test Market 2", epic: "TEST2", price: "200")
        ]
    }
}

