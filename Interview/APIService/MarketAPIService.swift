//
//  MarketAPIService.swift
//  Interview
//
//  Created by Thomas Romay on 21/10/2024.
//  Copyright © 2024 AJBell. All rights reserved.
//

import Foundation

protocol Fetchable: Sendable {
    associatedtype Model: Sendable
    func fetchMarkets() async throws -> [Model]
}

struct MarketRemoteAPIService: Fetchable {
    typealias Model = Market
    private let baseURL = "http://localhost:8080/api/general/money-am-quote-delayed"
    private let tickers = ["UKX", "MCX", "NMX", "ASX", "SMX", "AIM1", "IXIC", "INDU", "DEX"]

    private let session: NetworkSession
    init(session: NetworkSession? = nil, configuration: URLSessionConfiguration = .ephemeral) {
        if let session {
            self.session = session
        } else {
            configuration.protocolClasses = [NetworkInterceptor.self]
            self.session = URLSession(configuration: configuration)
        }
    }

    func fetchMarkets() async throws -> [Model] {
        let url = try constructURL(withTickers: tickers)
        let request = createRequest(for: url)
        let data = try await performNetworkRequest(with: request)
        return try parseMarketData(from: data)
    }

    // MARK: - Helper Methods

    private func constructURL(withTickers tickers: [String]) throws -> URL {
        let tickerString = tickers.joined(separator: ",")
        let urlString = "\(baseURL)?ticker=\(tickerString)"
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        return url
    }

    private func createRequest(for url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.addValue("Mock", forHTTPHeaderField: "Client")
        return request
    }

    private func performNetworkRequest(with request: URLRequest) async throws -> Data {
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return data
    }

    private func parseMarketData(from data: Data) throws -> [Market] {
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        guard let marketsData = json?["data"] as? [[String: Any]] else { throw URLError(.cannotParseResponse) }

        return marketsData.compactMap { dict in

            guard let name = dict["CompanyName"] as? String,
                  let epic = dict["Epic"] as? String,
                  let price = dict["CurrentPrice"] as? String else { return nil }
            return Market(name: name, epic: epic, price: price)
        }
    }
}
