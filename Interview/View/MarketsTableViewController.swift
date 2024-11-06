//
//  ViewController.swift
//  Interview
//
//  Created by Tiago on 04/04/2019.
//  Copyright © 2019 AJBell. All rights reserved.
//

import UIKit

class MarketsTableViewController: UITableViewController {
    private var viewModel = MarketViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    // MARK: - Table view data source methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.markets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let market = viewModel.markets[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = market.epic + " " + market.name
        cell.detailTextLabel?.text = market.price
        return cell
    }

    private func setup() {
        self.title = "Markets"
        Task {
            await loadMarkets()
        }
    }

    // MARK: - Load markets from ViewModel

    private func loadMarkets() async {
        await viewModel.fetchMarkets()

        if let errorMessage = viewModel.errorMessage {
            showErrorAlert(message: errorMessage)
        } else {
            tableView.reloadData()
        }
    }

    //A helper function to display an error alert
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
