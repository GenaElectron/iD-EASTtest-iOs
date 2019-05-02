//
//  SectionContentTableViewDataSource.swift
//  iDEASTTest-iOs
//
//  Created by Admin on 28.04.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import CollectionAndTableViewCompatible

protocol SectionContentTableViewDataSourceProtocol {
    var resultHandler: ItemClosure<SectionContentTableViewDataSourceHandler>? { get set }
    func prepareData()
    func refreshData()
}

class SectionContentTableViewDataSource: TableViewDataSource, SectionContentTableViewDataSourceProtocol {    
    private let sectionContentNetworkService: SectionContentNetworkServiceProtocol = SectionContentNetworkService()
    
    let section: Section
    
    var resultHandler: ItemClosure<SectionContentTableViewDataSourceHandler>?
    
    init(section: Section, tableView: UITableView) {
        self.section = section
        super.init(tableView: tableView)
        sections.append(TableViewSection(sortOrder: 0, items: []))
    }
    
//    deinit {
//        print("SectionContentTableViewDataSource deinit")
//    }
    
    private var isLoaded = false {
        didSet {
            if isLoaded == true{
                self.resultHandler?(.removeFotterView)
            }
        }
    }
    
    private var isPrepared = false
    
    private var isLoading = false
    
    private var page = 1
    
    private let pagesPerBatch  = 20
    
    func prepareData() {
        guard !isPrepared else { return }
        fetch(page: page, pageSize: pagesPerBatch) {[weak self] data, error in
            if let error = error {
                self?.resultHandler?(.showErrorWithAction(error))
                return
            }
            if let items = data {
                self?.isPrepared = true
                self?.sections.first?.items.append(contentsOf: items)
                self?.resultHandler?(.reloadTableView)
            }
        }
    }
    
    func refreshData() {
        guard !isLoading, isPrepared else {
            self.resultHandler?(.endRefreshing)
            return
        }
        isLoaded = false
        page = 1
        fetch(page: page, pageSize: pagesPerBatch) {[weak self] data, error in
            if let error = error {
                self?.resultHandler?(.endRefreshing)
                self?.resultHandler?(.showErrorWithoutAction(error))
                return
            }
            if let items = data {
                self?.sections.first?.items.removeAll()
                self?.sections.first?.items.append(contentsOf: items)
                self?.resultHandler?(.endRefreshing)
                self?.resultHandler?(.reloadTableView)
            }
        }
    }
    
    private func loadMore() {
        guard !isLoading, !isLoaded else { return }
        self.resultHandler?(.addFotterView)
        fetch(page: page, pageSize: pagesPerBatch) {[weak self] data, error in
            if let error = error {
                self?.resultHandler?(.showErrorWithoutAction(error))
                self?.resultHandler?(.removeFotterView)
                return
            }
            if let items = data {
                self?.sections.first?.items.append(contentsOf: items)
                self?.resultHandler?(.reloadTableView)
            }
        }
    }
    
    private func fetch(page: Int, pageSize: Int,_ completion: @escaping OptionalItemClosureWithError<[TableViewCompatible]>) {
        isLoading = true
        sectionContentNetworkService.fetchSectionContent(section: section, page: page, pageSize: pagesPerBatch) {[weak self] data, error in
            self?.isLoading = false
            if let error = error {
                completion(nil, error)
                return
            }
            guard
                let responceSectionContent = data,
                let fetchContent = responceSectionContent.content,
                let fetchTotal = responceSectionContent.total,
                let fetchPages = responceSectionContent.pages
                else {
                    let error = ApplicationError(description: "SectionContentTableViewDataSource ERROR: bad responce section data")
                    completion(nil, error)
                    return
            }
            guard fetchTotal != 0 else {
                self?.resultHandler?(.showMessageEmptyData)
                return
            }
            let items: [TableViewCompatible] = fetchContent.map { return SectionContentCellModel(content: $0) }
            
            if self?.page == fetchPages{
                self?.isLoaded = true
            } else {
                self?.page += 1
            }
            completion(items, nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == numberOfRowsInSection(section: indexPath.section) - 1 {
            loadMore()
        }
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
}

enum SectionContentTableViewDataSourceHandler {
    case endRefreshing
    case addFotterView
    case removeFotterView
    case reloadTableView
    case showMessageEmptyData
    case showErrorWithoutAction(_ error: Error)
    case showErrorWithAction(_ error: Error)
}
