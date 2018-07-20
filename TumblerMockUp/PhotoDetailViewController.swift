//
//  PhotoDetailViewController.swift
//  TumblerMockUp
//
//  Created by Aristotle on 2017-11-18.
//  Copyright © 2017 HLPostman. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var detailPhotoImageView: UIImageView!
    var photoURL: URL?

    @IBOutlet weak var captionLabel: UILabel!
    var caption: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let photoURL = photoURL {
            detailPhotoImageView.af_setImage(withURL: photoURL)
        }
        // Remove the initial <p>" and closing "</p>
        caption = caption!
        caption!.removeFirst(4)
        caption!.removeLast(5)
        captionLabel.text! = caption!
        print(caption!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
