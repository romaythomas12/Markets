//
//  MarketsViewModel.swift
//  Interview
//
//  Created by Thomas Romay on 21/10/2024.
//  Copyright © 2024 AJBell. All rights reserved.
//

import Combine
import Foundation

@MainActor
class MarketViewModel {
    @Published private(set) var markets: [Market] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?
    
    private let marketService: any Fetchable
    
    init(marketService: any Fetchable = MarketRemoteAPIService()) {
        self.marketService = marketService
    }
    
    func fetchMarkets() async {
        isLoading = true
        errorMessage = nil
        do {
            let markets = try await marketService.fetchMarkets()
            self.markets = markets.compactMap { $0 as? Market }
        }
        catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
