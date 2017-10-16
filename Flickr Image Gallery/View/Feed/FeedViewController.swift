//
//  ViewController.swift
//  Flickr Image Gallery
//
//  Created by Enrique Melgarejo on 13/10/17.
//  Copyright © 2017 Choynowski. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: Properties
    private let refreshControl = UIRefreshControl()
    internal let viewModel = FeedViewModel()
    fileprivate let interItemSpacing: CGFloat = 10

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupRefreshControl()
        setupCollectionView()
        setupUI()
        setupViewModel()
    }

    // MARK: Methods
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    }

    private func setupCollectionView() {

        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refreshControl
        } else {
            collectionView.addSubview(refreshControl)
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: interItemSpacing, bottom: 0, right: interItemSpacing)
        collectionView.register(UINib(nibName: FlickrPhotoCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: FlickrPhotoCollectionViewCell.identifier)
    }

    private func setupUI() {
        title = viewModel.title
    }

    private func setupViewModel() {
        viewModel.onDataSourceChanged = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }

        viewModel.onDataSourceFailed = { [weak self] error in
            DispatchQueue.main.async {
                self?.showAlert(withTitle: "Failed to load images.", message: error?.localizedDescription)
                self?.refreshControl.endRefreshing()
            }
        }
        refreshControl.beginRefreshing()
        viewModel.loadFeed()
    }

    @objc
    private func pullToRefresh(_ sender: Any) {
        viewModel.loadFeed()
    }

    func showAlert(withTitle title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    @IBAction func barButtonRefreshPressed(_ sender: UIBarButtonItem) {
        refreshControl.beginRefreshing()
        viewModel.loadFeed()
    }
}

extension FeedViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(for: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let identifier = viewModel.identifier(for: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        if let photoCell = cell as? FlickrPhotoCollectionViewCell {
            let photoViewModel = viewModel.data(for: indexPath)
            photoCell.bind(with: photoViewModel)
        }
        return cell
    }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let contentInset = collectionView.contentInset
        let currentWidth = collectionView.bounds.width
        let width = currentWidth - contentInset.left - contentInset.right - interItemSpacing
        return CGSize(width: width / 2, height: width / 2)
    }
}
