//
//  ResultsViewController.swift
//  DistanceCalculator
//
//  Created by Mitul Manish on 14/3/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit
import Popper

class ResultsViewController: UIViewController {
    private lazy var handlerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .groupTableViewBackground
        view.layer.cornerRadius = 4
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let guests: [Guest]
    
    init(guests: [Guest]) {
        self.guests = guests
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setupHandlerView()
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        view.round(corners: [.topLeft, .topRight], radius: 8)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        [tableView.topAnchor.constraint(equalTo: handlerView.bottomAnchor, constant: 16),
         tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
         tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
         tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1)
            ].forEach { $0.isActive = true }
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.bounds.height / 3.0, right: 0)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.5)
        tableView.backgroundColor = .gray
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupHandlerView() {
        view.addSubview(handlerView)
        [handlerView.heightAnchor.constraint(equalToConstant: 4),
         handlerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         handlerView.widthAnchor.constraint(equalToConstant: 90),
         handlerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
            ].forEach { $0.isActive = true }
    }
}

extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}

extension ResultsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let guest = guests[indexPath.item]
        cell.textLabel?.text = "\(guest.userID). \(guest.userName)  - \(guest.distanceFromSourceDescription)"
    }
}
