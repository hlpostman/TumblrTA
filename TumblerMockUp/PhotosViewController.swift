//
//  PhotosViewController.swift
//  TumblerMockUp
//
//  Created by Aristotle on 2017-11-11.
//  Copyright © 2017 HLPostman. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var posts: [[String: Any]] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // TableView setup
        tableView.delegate = self
        tableView.dataSource = self
        
        // Network request snippet
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print(dataDictionary)
                
                // Get the dictionary from the response key
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                // Store the returned array of dictionaries in our posts property
                self.posts = responseDictionary["posts"] as! [[String: Any]]
            }
            // Reload data
            self.tableView.reloadData()
        }
        task.resume()

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count //posts initialized to [] so never nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let post = posts[indexPath.row]
        if let photos = post["photos"] as? [[String: Any]] {
            // photos is NOT nil, we can use it!
            // Get URL for post image
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            print(originalSize)
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            cell.photoImageView.af_setImage(withURL: url!)
        }
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PhotoDetailViewController
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        
        let post = posts[(indexPath?.row)!]
        if let photos = post["photos"] as? [[String: Any]] {
            // photos is NOT nil, we can use it!
            // Get URL for post image
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            print(originalSize)
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            vc.photoURL = url!
        }
        // Send caption
        if let caption = post["caption"] as? String {
            vc.caption = caption
        }
        
        
    }

}
