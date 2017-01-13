//
//  NewsItemAdminVC.swift
//  JasperScholten-project
//
//  Created by Jasper Scholten on 12-01-17.
//  Copyright © 2017 Jasper Scholten. All rights reserved.
//

import UIKit

class NewsItemAdminVC: UIViewController {

    @IBOutlet weak var newsItemImage: UIImageView!
    @IBOutlet weak var newsItemTitle: UITextView!
    @IBOutlet weak var newsItemText: UITextView!
    
    var image = UIImage()
    var itemTitle = String()
    var itemDate = String()
    var itemText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsItemText.textAlignment = .justified
        newsItemTitle.text = itemTitle
        newsItemText.text = "\(itemDate) - \(itemText)"
        newsItemImage.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
