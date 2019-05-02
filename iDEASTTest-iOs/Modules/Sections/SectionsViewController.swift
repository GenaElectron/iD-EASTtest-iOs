//
//  SectionsViewController.swift
//  iDEASTTest-iOs
//
//  Created by Admin on 27.04.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class SectionsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private let refreshControl = UIRefreshControl()
    
    private var data: SectionsTableViewDataSourceProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        data = SectionsTableViewDataSource(tableView: tableView)
        configureTableView()
        configureRefreshControll()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SectionContentViewController.sequeIdentifer{
            let vc = segue.destination as! SectionContentViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                let sectionsTableViewCell = self.tableView.cellForRow(at: indexPath) as? SectionsTableViewCell
                vc.section = sectionsTableViewCell?.model?.rawData
            }
        }
    }
    
    private func setEventHandlerFromData() {
        data.resultHandler = ({ [weak self] handler in
            DispatchQueue.main.async {
                switch handler{
                case .showMessageEmptyData:
                    self?.spinner.stopAnimating()
                    self?.showAlert(with: "Message", and: "Data for sections is empty", buttonTitle: "OK" )
                case .showErrorWithAction(let error):
                    self?.spinner.stopAnimating()
                    self?.showAlert(with: "Error", and: "Error communicating with the server, try updating the connection. Detail: \(error.localizedDescription)", buttonTitle: "Update") {
                        self?.spinner.startAnimating()
                        self?.prepareData()
                    }
                case .showErrorWitoutAction(let error):
                    self?.spinner.stopAnimating()
                    self?.showAlert(with: "Error", and: "Error communicating with the server, try updating the connection. Detail: \(error.localizedDescription)", buttonTitle: "OK")
                case .reloadTableView:
                    self?.spinner.stopAnimating()
                    self?.tableView.reloadData()
                case .endRefreshing:
                    self?.endRefreshing()
                    self?.scrollToTop()
                }
            }
        })
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
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
        tableView.register(SectionsTableViewCell.nib, forCellReuseIdentifier: SectionsTableViewCell.name)
    }
}

extension SectionsViewController: UITableViewDelegate {    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SectionContentViewController.sequeIdentifer, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
