//
//  BuyStocksViewController.swift
//  Stocks App
//
//  Created by liram vahadi on 12/02/2021.
//

import UIKit

//TODO: - Change Names to func and var
class StocksListViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properties
    var presenter: StockListPresenter?
    let emptyView = EmptyViewDuringLoadingData()
    let activityIndicator = UIActivityIndicatorView()

    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = StockListPresenter(delegate: self)
        keyboardDissmis()
    }
    
    //MARK: Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == ConstantValues.SegueIdentifier.buyStock{
            if let viewController = segue.destination as? TradeStockViewController{
                viewController.symbol = presenter?.passDataSelectedItem().symbol
                viewController.company = presenter?.passDataSelectedItem().company
                viewController.buttonTitle = TradeOptions.purchase.rawValue
            }
        }
    }
    
}

//MARK: Extenssions
extension StocksListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: StocksTableViewCell.identifierCell) as? StocksTableViewCell{
            let stockModel = presenter?.getStockModel(indexPath.section, indexPath.row)
            cell.configureCell(model: stockModel!)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = HeaderSectionView()
        let headerTitle = presenter?.getStockIndsturyName(at: section)
        header.setHeaderViewSection(title: headerTitle!, section: section)
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectStock(indexPath.section, indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

extension StocksListViewController: BuyStockViewDelegate{
   
    func showEmptyViewLoadData() {
        emptyView.showEmptyView(with: self, view: view, activitiIndicator: activityIndicator)
    }
    
    func appearErrorDialog(message: String) {
            appearDialogToUser(title: "Oops", message: message)
    }
    
    func reloadData() {
        emptyView.hideEmptyView(stop: activityIndicator)
        tableView.reloadData()
    }
    
    func navigatoToStockDetails() {
        performSegue(withIdentifier: ConstantValues.SegueIdentifier.buyStock, sender: nil)
    }
    
}

extension StocksListViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchIndstury(searchText)
    }
}


