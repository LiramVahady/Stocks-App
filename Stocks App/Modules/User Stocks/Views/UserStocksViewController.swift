//
//  ViewController.swift
//  Stocks App
//
//  Created by liram vahadi on 01/02/2021.
//

import UIKit
import RealmSwift

class UserStocksViewController: UIViewController {
    
    //MARK: @IBOutler
    @IBOutlet weak var statusBalanceImage: UIImageView!
    @IBOutlet weak var userBalanceLabel: UILabel!
    @IBOutlet weak var currencyTableView: UITableView!
    @IBOutlet weak var userStocksTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var logoutBarButton: UIBarButtonItem!
   
    //MARK: Properties
    private let api = ApiService.shared
    private var presenter: UserStocksPresenter?
    private var window: UIWindow?
    private var activityIndicatorView = UIActivityIndicatorView()
    private var emptyView = EmptyViewDuringLoadingData()
    private let realm = RealmService.shared
   
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = UserStocksPresenter(delegate: self)
        configurePage()
    
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setupBalance()
        presenter?.loadStocks()
    }
    
    //MARK: Actions
    @IBAction func logoutTapped(_ sender: Any) {
        
        UserDefaultsManagement.saveUserSuccessLogin(false)
        performSegue(withIdentifier: ConstantValues.SegueIdentifier.logout, sender: nil)
        
    }
    
    //MARK: Function
    private func configurePage(){
        
        keyboardDissmis()
        statusBalanceImage.image = UIImage(systemName: ConstantValues.systemImageNameProtfolioStatus.statusNotEarn)
        statusBalanceImage.tintColor = .gray
        configureTableView()
    }
    
    func configureTableView(){
        
        currencyTableView.tableFooterView = UIView(frame: .zero)
        currencyTableView.separatorInset = UIEdgeInsets.zero
        userStocksTableView.tableFooterView = UIView()
    }
    
    private func setupBalance(){
        
        let currentBalance = CurrentBalnce.setupUserBalance()
        userBalanceLabel.text = "Your Balance: \(currentBalance)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  segue.identifier == ConstantValues.SegueIdentifier.sellStock{
            if let viewController = segue.destination as? TradeStockViewController{
                
                viewController.symbol = presenter?.passDataToSellStock().symbol
                viewController.company = presenter?.passDataToSellStock().company
                viewController.buttonTitle = TradeOptions.sell.rawValue
            }
        }
        
        if segue.identifier == ConstantValues.SegueIdentifier.logout{
            if let viewController = segue.destination as? LoginViewController{
                
                viewController.hidesBottomBarWhenPushed = true
                viewController.navigationItem.hidesBackButton = true
                viewController.emptyView.showEmptyView(with: viewController, view: viewController.view, activitiIndicator: viewController.activityIndicatorView)
            }
        }
    }
    
}

extension UserStocksViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let numberOfRows = presenter?.numberOfRows, let userStockRows = presenter?.userStocksNumberOfRows else {return 0}
        
        return  tableView == currencyTableView ? numberOfRows : userStockRows

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.currencyCellIdetntifier) as? CurrencyTableViewCell{
            
            let currencyModel = presenter?.getCurrencyModel(at: indexPath.row)
            cell.configureCell(with: currencyModel!)
            return cell
    }
                
        if let cell = tableView.dequeueReusableCell(withIdentifier: UserStocksTableViewCell.cellIdentifier) as? UserStocksTableViewCell{
            let userStocks = presenter?.getUserStockModel(at: indexPath.row)
           
            cell.configureCell(userStocks: userStocks!)
            return cell
        }
       
        return UITableViewCell()
       
    }
      
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if tableView == userStocksTableView{
            return "Current Stocks Holding"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == currencyTableView{
            return 65
        }
        
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView == currencyTableView{
            presenter?.performExchangeOnSelectedItem(at: indexPath.row)
            presenter?.loadStocks()
        }
       
        if tableView == userStocksTableView{
            presenter?.sellStockDidSelectedItem(at: indexPath.row)
        }
        
    }
        
}
    
extension UserStocksViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let text = searchBar.text else {return}
        presenter?.didUserSearch(text: text)
    }
}

extension UserStocksViewController: UserStocksViewDelegate{
    
    func exchangeCurrency(with newValue: [String : Double]) {
        
        let userBalance = CurrentBalnce.currentBalance * newValue.values.first!
        
        userBalanceLabel.text = "Your Balance: \(userBalance.currencyFormatter()) \(newValue.keys.first!)"
    }
    
    func showEmptyViewLoadData() {
        
        emptyView.showEmptyView(with: self, view: view, activitiIndicator: activityIndicatorView)
        
    }
    
    func reloadData() {
        
        emptyView.hideEmptyView(stop: activityIndicatorView)
        currencyTableView.reloadData()
        
    }

    func errorOccurs(display message: String?) {
        
        guard let message = message else {return}
        appearDialogToUser(title: "Oops", message: message)
    }
    
    func hideUserStocksComponent() {
        
        emptyView.hideCell(userStocksTableView)
    }
    
    func reloadUserStocks() {
        
        emptyView.showCell(userStocksTableView)
        userStocksTableView.reloadData()
    }
    
    func navigateToSellStcok() {
        
        performSegue(withIdentifier: ConstantValues.SegueIdentifier.sellStock, sender: nil)
    }
    
    func totalProtfolioValue(_ currentValueStock: Double, _ totalProtfolioPrice: Double) {
       
        if currentValueStock == totalProtfolioPrice{
            print("1")
            statusBalanceImage.image = UIImage(systemName: ConstantValues.systemImageNameProtfolioStatus.statusNotEarn)
           
            
        }else if currentValueStock > totalProtfolioPrice{
            
            statusBalanceImage.image = UIImage(systemName:ConstantValues.systemImageNameProtfolioStatus.statusLost)
            statusBalanceImage.tintColor = .red
          
            
        }else if currentValueStock < totalProtfolioPrice{
            
            statusBalanceImage.image = UIImage(systemName: ConstantValues.systemImageNameProtfolioStatus.statusEarn)
            statusBalanceImage.tintColor = .green
            
        }
    }
}

