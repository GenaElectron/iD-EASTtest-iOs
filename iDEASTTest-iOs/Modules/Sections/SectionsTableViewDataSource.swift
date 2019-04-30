//
//  SectionsTableViewDataSource.swift
//  iDEASTTest-iOs
//
//  Created by Admin on 27.04.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import CollectionAndTableViewCompatible

protocol SectionsTableViewDataSourceProtocol {
    var resultHandler: ItemClosure<SectionsTableViewDataSourceHandler>? { get set }
    subscript(indexPath: IndexPath) -> TableViewCompatible { get set }
    func prepareData()
    func refreshData()
}

class SectionsTableViewDataSource: TableViewDataSource, SectionsTableViewDataSourceProtocol {
    
    private let sectionsNetworkService: SectionsNetworkServiceProtocol = SectionsNetworkService()
    
    var resultHandler: ItemClosure<SectionsTableViewDataSourceHandler>?
    
    override init(tableView: UITableView) {
        super.init(tableView: tableView)
        sections.append(TableViewSection(sortOrder: 0, items: []))
    }
    
    private var isLoading = false
    
    func prepareData() {
        fetch(completion: {[weak self] data, error in
            if let error = error {
                self?.resultHandler?(.showErrorWithAction(error))
                return
            }
            if let items = data {
                self?.sections.first?.items.append(contentsOf: items)
                self?.resultHandler?(.reloadTableView)
            }
        })
    }
    
    func refreshData() {
        guard !isLoading else {
            self.resultHandler?(.endRefreshing)
            return
        }
        fetch(completion: {[weak self] data, error in
            if let error = error {
                self?.resultHandler?(.endRefreshing)
                self?.resultHandler?(.showErrorWitoutAction(error))
                return
            }
            if let items = data {
                self?.sections.first?.items.removeAll()
                self?.sections.first?.items.append(contentsOf: items)
                self?.resultHandler?(.endRefreshing)
                self?.resultHandler?(.reloadTableView)
            }
        })
    }
    
    private func fetch(completion: @escaping OptionalItemClosureWithError<[TableViewCompatible]>) {
        isLoading = true
        sectionsNetworkService.fetchSections { data, error in
            self.isLoading = false
            if let error = error {
                completion(nil, error)
                return
            }
            guard
                let responce = data,
                let fetchContent = responce.content,
                let fetchTotal = responce.total
                else {
                    let error = ApplicationError(description: "SectionsTableViewDataSource ERROR: bad responce section data")
                    completion(nil, error)
                    return
            }
            guard fetchTotal != 0 else {
                self.resultHandler?(.showMessageEmptyData)
                return
            }
            var items = [TableViewCompatible]()

            for section in fetchContent {
                let sectionCellModel = SectionsCellModel(section: section)
                items.append(sectionCellModel)
            }
            completion(items, nil)
        }
    }
}

enum SectionsTableViewDataSourceHandler {
    case endRefreshing
    case reloadTableView
    case showMessageEmptyData
    case showErrorWithAction(_ error: Error)
    case showErrorWitoutAction(_ error: Error)
}
