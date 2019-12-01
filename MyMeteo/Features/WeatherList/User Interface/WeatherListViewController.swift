//
//  WeatherListViewController.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import UIKit

class WeatherListViewController: UIViewController, Loadable {

    // MARK: - Constant

    private enum Constant {
        static let tableViewInsetsTop: CGFloat = 0
        static let tableViewInsets: CGFloat = 0
        static let weatherListTableViewCellIdentifier: String = "WeatherListTableViewCell"
        static let estimatedFooterHeight: CGFloat = 0.0
        static let footerHeight: CGFloat = UITableView.automaticDimension
    }

    // MARK: - Property

    var presenter: WeatherListPresenterInput!
    var imageLoader: ImageLoader!

    @IBOutlet private(set) weak var tableView: UITableView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()

        setupTableView()
    }

    // MARK: - Privates

    private func registerCell() {
        tableView.register(UINib(nibName: Constant.weatherListTableViewCellIdentifier, bundle: nil), forCellReuseIdentifier: Constant.weatherListTableViewCellIdentifier)
    }

    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsets(top: Constant.tableViewInsetsTop,
                                              left: Constant.tableViewInsets,
                                              bottom: Constant.tableViewInsets,
                                              right: Constant.tableViewInsets)

        registerCell()
    }

}

// MARK: - UITableViewDataSource

extension WeatherListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection(section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let viewModel = presenter.viewModelForRowAtIndexPath(indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeatherListTableViewCell.self),
                                                       for: indexPath) as? WeatherListTableViewCell else {
                                                        return UITableViewCell()
        }
        cell.cityNameLabel.attributedText = viewModel.name
        cell.weatherCurrentTemperatureLabel.attributedText = viewModel.weatherCurrentTemperature
        imageLoader.loadImage(imageView: cell.weatherIconImageView, url: viewModel.weatherIconImageURL, placeholder: viewModel.weatherIconImagePlaceholder)
        cell.weatherDescriptionLabel.attributedText = viewModel.weatherDescription
        cell.weatherMinMaxTemperatureLabel.attributedText = viewModel.weatherMinMaxTemperature
        return cell
    }
}

// MARK: - UITableViewDelegate

extension WeatherListViewController: UITableViewDelegate {
    func tableView(_: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

// MARK: - UITableViewDataSourcePrefetching

extension WeatherListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        presenter.prefetchRowsAtIndexPaths(indexPaths)
    }

    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        presenter.cancelPrefetchingForRowsAt(indexPaths)
    }
}

// MARK: - WeatherListPresenterOutput

extension WeatherListViewController: WeatherListPresenterOutput {
    func displayTitle(_ title: String) {
        self.title = title
    }

    func showLoader() {
        startLoading()
    }

    func hideLoader() {
        stopLoading()
    }


    func reloadRows(_ indexPaths: [IndexPath]) {
        tableView.reloadRows(at: indexPaths, with: .fade)
    }

    func reloadData() {
        tableView.reloadData {
            self.presenter.prefetchRowsAtIndexPaths(self.tableView.indexPathsForVisibleRows)
        }
    }

    func displayError(_ param: AlertParamsProtocol) {
        presentAlertPopupWithTextfield(param.title,
                                       message: param.message,
                                       confirmationTitle: param.buttonOkTitle)
    }
}
