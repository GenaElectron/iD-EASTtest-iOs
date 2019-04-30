//
//  SectionContentViewController.swift
//  iDEASTTest-iOs
//
//  Created by Admin on 28.04.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class SectionContentViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private var footerView: UIView?
    private let refreshControl = UIRefreshControl()
    
    static let sequeIdentifer = "showSectionContentViewController"
    
    var section: Section!
        
    private var data: SectionContentTableViewDataSourceProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard section != nil else { fatalError() }
        data = SectionContentTableViewDataSource(section: section, tableView: tableView)
        setTitleText(with: section.webTitle)
        registerCells()
        configureTableView()
        configureRefreshControll()
        configureFotterView()
        setEventHandlerFromData()
        prepareData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    private func setEventHandlerFromData() {
        data.resultHandler = ({ [weak self] handler in
            DispatchQueue.main.async {
                //self?.spinner.stopAnimating()
                switch handler{
                    case .showMessageEmptyData:
                        self?.spinner.stopAnimating()
                        self?.showAlert(with: "Message", and: "Section is empty", buttonTitle: "OK", actionHandler: {
                            self?.navigationController?.popViewController(animated: true)
                        })
                    case .showErrorWithoutAction(let error):
                        self?.spinner.stopAnimating()
                        self?.showAlert(with: "Error", and: "Error communicating with the server, try updating the connection. Detail: \(error.localizedDescription)", buttonTitle: "OK")
                    case .showErrorWithAction(let error):
                        self?.spinner.stopAnimating()
                        self?.showAlertWithCancel(with: "Error", and: "Error communicating with the server, try updating the connection. Detail: \(error.localizedDescription)", buttonTitle: "Update", cancelHandler: {
                            self?.navigationController?.popViewController(animated: true)
                        }, actionHandler: {
                            self?.spinner.startAnimating()
                            self?.prepareData()
                        })
                    case .reloadTableView:
                        self?.spinner.stopAnimating()
                        self?.tableView.reloadData()
                    case .removeFotterView:
                        self?.removeFotterView()
                    case .addFotterView:
                        self?.addFotterView()
                    case .endRefreshing:
                        self?.endRefreshing()
                        self?.scrollToTop()
                    }
                }
        })
    }
    
    private func setTitleText(with titleText: String?) {
        title = titleText
    }
    
    private func configureFotterView() {
        footerView = ViewWithSpinner.loadFromNib()
    }
    
    private func addFotterView() {
        if tableView.tableFooterView == nil {
            tableView.tableFooterView = footerView
        }
    }
    
    private func removeFotterView() {
        tableView.tableFooterView = nil
    }
    
    private func configureTableView() {
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.refreshControl = refreshControl
    }
    
    private func scrollToTop() {
        tableView.setContentOffset(CGPoint.zero, animated: true)
    }
    
    private func configureRefreshControll(){
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    @objc private func refreshData(_ sender: Any) {
        data.refreshData()
    }
    
    private func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    private func prepareData() {
        data.prepareData()
    }
        
    private func registerCells() {
        tableView.register(SectionContentTableViewCell.nib, forCellReuseIdentifier: SectionContentTableViewCell.name)
    }
}

