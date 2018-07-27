//
//  PhotoListViewController.swift
//  ListPhotoGallery
//
//  Created by Ionut Baciu on 24/07/2018.
//  Copyright © 2018 Ionut Baciu. All rights reserved.
//

import UIKit

class PhotoListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var viewModel: PhotoListViewModel = {
        return PhotoListViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initVM()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initView() {
        self.navigationItem.title = "Photos"
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func initVM() {
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tableView.alpha = 0.0
                    })
                } else {
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tableView.alpha = 1.0
                    })
                }
            }
        }
        
        viewModel.reloadTableViewC = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.initFetch()
    }
}

extension PhotoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCellIdentifier", for: indexPath) as! PhotoListTableViewCell
        let photo = viewModel.getCellViewModel(at: indexPath)
        cell.setPhoto(photo: photo)
        return cell
    }
}

extension PhotoListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = tableView.indexPath(for: sender as! PhotoListTableViewCell)!
        if let vc = segue.destination as? ImageViewController {
            if let cell = tableView.cellForRow(at: index) as? PhotoListTableViewCell {
                tableView.deselectRow(at: index, animated: true)
                if let text = cell.descriptionLabel.text {
                    vc.text = text
                }
                if let img = cell.imageViewCell.image {
                    vc.image = img
                }
            }
        }
    }
}
