//
//  InterviewTests.swift
//  InterviewTests
//
//  Created by Tiago on 04/04/2019.
//  Copyright © 2019 AJBell. All rights reserved.
//

import Testing
import Foundation
@testable import Interview

struct MarketsViewModelTests  {
    @MainActor
    @Test func testLoadMarketsSuccess() async {
        // Arrange
        let mockService = MockMarketService()
        let viewModel =  MarketViewModel(marketService: mockService)
        
        // Act
        await viewModel.fetchMarkets()
        
        // Assert
        #expect(viewModel.markets.count == 2)
        #expect(viewModel.markets[0].name == "Test Market 1")
        #expect(viewModel.markets[1].epic == "TEST2")
        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage == nil)
    }

    
    @MainActor
    @Test func testLoadMarketsError() async {
        // Arrange
        let mockService = MockMarketService(shouldReturnError: true)
        let viewModel = MarketViewModel(marketService: mockService)
        
        // Act
        await viewModel.fetchMarkets()
        
        // Assert
        #expect(viewModel.markets.count == 0)
        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage != nil)
        #expect(viewModel.errorMessage == "The operation couldn’t be completed. (NSURLErrorDomain error -1011.)")
    }
    
    @MainActor
    @Test func testLoadingStateManagement() async {
        // Arrange
        let mockService = MockMarketService()
        let viewModel = MarketViewModel(marketService: mockService)
        
        // Act
        #expect(viewModel.isLoading == false)
        await viewModel.fetchMarkets()
        #expect(viewModel.isLoading == false) // After loading, it should be false
    }
    
}
