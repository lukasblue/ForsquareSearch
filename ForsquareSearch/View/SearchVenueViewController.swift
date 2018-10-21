//
//  SearchVenueViewController.swift
//  ForsquareSearch
//
//  Created by Łukasz Wróblak on 20.10.2018.
//  Copyright © 2018 Łukasz Wróblak. All rights reserved.
//

import UIKit

class SearchVenueViewController: UIViewController {

    
    @IBOutlet weak var tfSearchVenues: UITextField!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var lblNoResults: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func onEditingChangedtfSearchVenues(_ sender: Any) {
        if let text  = tfSearchVenues.text {
//            if currentLat != nil && currentLng != nil {
                self.venuePresenter.getVenues(searchPhrase: text)
//            }
        }
    }
    
    var venues : VenueResponseDataModel?

    
    var venuePresenter  = VenuePresenter(venueRepository: VenuesRepository(), locationRepository: LocationRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tableView.register(UINib(nibName: "VenueTableViewCell", bundle: nil) ,  forCellReuseIdentifier: "VenueTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        venuePresenter.attachView(venueView: self)
        venuePresenter.getCurrentLocation()
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        if isMovingFromParentViewController {
            venuePresenter.detachView()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension SearchVenueViewController : VenueView {
    func showCannotFindYourLocation() {
        let alertController = UIAlertController (title: "Error", message: "Could not find your current location", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Try again", style: .default) { (_) -> Void in
            //TODO
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
        tfSearchVenues.isEnabled = false 
    }
    
    func showProgressView() {
        self.progressView.isHidden = false
    }
    
    func hideProgressView() {
        self.progressView.isHidden = true
    }
    
    func showVenues(venues: VenueResponseDataModel) {
        self.lblNoResults.isHidden = true
        self.venues = venues
        self.tableView.reloadData()
    }
    
    func showNoResults() {
        self.lblNoResults.isHidden = false
        self.venues = nil
        self.tableView.reloadData()
    }
    
}


extension SearchVenueViewController : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = venues?.response.venues.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VenueTableViewCell", for: indexPath) as! VenueTableViewCell
        cell.lblName.text = venues?.response.venues[indexPath.row].name
        cell.lblAddress.text = venues?.response.venues[indexPath.row].location.address
        if let venueDistance = venues?.response.venues[indexPath.row].location.distance {
            cell.lblDistance.text = "Distance -> \(venueDistance)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}

