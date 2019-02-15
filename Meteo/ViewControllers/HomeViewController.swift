//
//  HomeViewController.swift
//  Meteo
//
//  Created by Jeoffrey Thirot on 15/02/2019.
//  Copyright © 2019 Jeoffrey Thirot. All rights reserved.
//

import UIKit
import CocoaLumberjack
import Moya
import RxSwift

class HomeViewController: UIViewController {
    // MARK: - Variables
    // Private variables
    
    // Public variables
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Getter & Setter methods
    
    // MARK: - Constructors
    /**
     Method to create the manager of socket communications
     
     @param settings detail to launch the right sockets connection
     @param delegate used to dispatch event from sockets activities
     */
    
    // MARK: - Init behaviors
    
    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DDLogDebug("Hi 🎉")
        
        let provider = MoyaProvider<WeatherService>()
        provider.request(.hello) { (result) in
            var statusCode: Int
            switch result {
            case let .success(response):
                // Convert JSON String to Model
                let JSONString = String(data: response.data, encoding: .utf8)
                statusCode = response.statusCode
                DDLogDebug("data: \(JSONString!)")
            case let .failure(error):
                DDLogDebug("Failure request :( \(error.localizedDescription)")
                statusCode = (error.response?.statusCode != nil ? (error.response?.statusCode)! : 418)
            }
            DDLogDebug("Request on server(\(WeatherService.hello.path)) with status: \(statusCode)")
        }
        
        provider.rx.request(.hello).map(Weather.self).subscribe { event in
            switch event {
            case let .success(response):
//                DDLogDebug("Rx response: \(response)")
                DDLogDebug("Rx weather: \(response)")
                DDLogDebug("\n\n-------------\n\(response.dictionary())\n-------------\n\n")
//                let JSONString = String(data: response.data, encoding: .utf8)
//                DDLogDebug("Rx data: \(JSONString!)")
            case let .error(error):
                DDLogDebug("Rx error: \(error)")
            }
        }
        provider.rx.request(.hello).subscribe { event in
            switch event {
            case let .success(response):
                DDLogDebug("Rx response: \(response)")
                let JSONString = String(data: response.data, encoding: .utf8)
                DDLogDebug("Rx data: \(JSONString!)")
            case let .error(error):
                DDLogDebug("Rx error: \(error)")
            }
        }
    }
    
    @IBAction func searchHandler(_ sender: Any) {
        guard let searchVC = self.storyboard?.instantiateViewController(withIdentifier: "searchVC") as? SearchLocationViewController else {
            print("You have a problem here!")
            return
        }
        self.navigationController?.present(searchVC, animated: true, completion: nil)
    }
    
    // MARK: - Private methods
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
