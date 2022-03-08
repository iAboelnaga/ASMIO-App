//
//  SortViewController.swift
//  ASMIO App
//
//  Created by Ahmed Aboelnaga on 06/03/2022.
//

import UIKit

protocol SortDelegate: AnyObject {
    func didSelect(sortOption: SortOptions)
}

class SortViewController: UIViewController {
    @IBOutlet weak var sortOptionsTableView: SelfSizedTableView! {
        didSet {
            setupTableView()
        }
    }
    
    var selectedOption: SortOptions = .popularity
    weak var delegate: SortDelegate?
    let viewModel = SortViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.selectedOption = self.selectedOption
        sortOptionsTableView.reloadData()
    }
    
    func setupTableView() {
        sortOptionsTableView.delegate = self
        sortOptionsTableView.dataSource = self
        sortOptionsTableView.registerCellNib(cellClass: SortTableViewCell.self)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss()
    }
}


extension SortViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(sortOption: viewModel.sortOptions[indexPath.row])
    }
}

extension SortViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sortOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as SortTableViewCell
        cell.configure(with: viewModel.sortOptions[indexPath.row].rawValue,
                       selection: viewModel.sortOptions[indexPath.row] == viewModel.selectedOption)
        return cell
    }
}
