//
//  HomeViewController.swift
//  Meteo
//
//  Created by Jeoffrey Thirot on 15/02/2019.
//  Copyright © 2019 Jeoffrey Thirot. All rights reserved.
//

import UIKit

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
        
        // Do any additional setup after loading the view.
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
