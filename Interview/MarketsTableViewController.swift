//
//  ViewController.swift
//  Interview
//
//  Created by Tiago on 04/04/2019.
//  Copyright © 2019 AJBell. All rights reserved.
//

import UIKit


class Market {
    var name: String
    var epic: String
    var price: String
    
    init(name: String, epic: String, price: String) {
        self.name = name
        self.epic = epic
        self.price = price
    }
}

class MarketsTableViewController: UITableViewController {
    
    
    var markets: [Market]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadMarkets()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.markets?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let market = self.markets![indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = market.epic + " " + market.name
        cell.detailTextLabel?.text = market.price
        return cell
    }
    
    func loadMarkets() {
        let url = "http://localhost:8080/api/general/money-am-quote-delayed?ticker=UKX,MCX,NMX,ASX,SMX,AIM1,IXIC,INDU,DEX."
        var request = URLRequest(url: URL(string: url)!)
        request.addValue("Mock", forHTTPHeaderField: "Client")
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [NetworkInterceptor.self]
        let defaultSession = URLSession(configuration: configuration)
        
        defaultSession.dataTask(with: request) { (data, response, error) in
            var resultMarkets = [Market]()
            if let result = try? JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, Any>,
                let marketsData = result["data"] as? Array<Dictionary<String, Any>> {
                marketsData.forEach {
                    let market = Market(name: $0["CompanyName"] as! String,
                                        epic: $0["Epic"] as! String,
                                        price: $0["CurrentPrice"] as! String)
                    resultMarkets.append(market)
                }
                
                self.markets = resultMarkets
                
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                }
            }
            
            
        }.resume()
        
    }
    
}
