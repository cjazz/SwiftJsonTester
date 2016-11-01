//
//  ViewController.swift
//  SwiftJsonTester
//
//  Created by Adam Chin
//  Copyright © 2016 hushbox. All rights reserved.
//
// SwiftJsonTester/MoreOffers.json
import UIKit

class ViewController: UIViewController, URLSessionDownloadDelegate, UIDocumentInteractionControllerDelegate {
    
    let url_to_request:String = "https://raw.githubusercontent.com/cjazz/SwiftJsonTester/master/MoreOffers.json"
    
    var downloadTask: URLSessionDownloadTask!
    var backgroundSession: Foundation.URLSession!
    
    @IBOutlet weak var VButton: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        VButton.layer.cornerRadius = 5
        VButton.layer.borderWidth = 1
        VButton.layer.borderColor = UIColor.black.cgColor
        
        
        let backgroundSessionConfiguration = URLSessionConfiguration.background(withIdentifier: "backgroundSession")
        backgroundSession = Foundation.URLSession(configuration: backgroundSessionConfiguration, delegate: self, delegateQueue: OperationQueue.main)
        progressView.setProgress(0.0, animated: false)

    }

    @IBAction func startDownload(_ sender: AnyObject) {
        let url = URL(string: url_to_request)!
        downloadTask = backgroundSession.downloadTask(with: url)
        downloadTask.resume()
    }
    @IBAction func pause(_ sender: AnyObject) {
        if downloadTask != nil{
            downloadTask.suspend()
        }
    }
    @IBAction func resume(_ sender: AnyObject) {
        if downloadTask != nil{
            downloadTask.resume()
        }
    }
    @IBAction func cancel(_ sender: AnyObject) {
        if downloadTask != nil{
            downloadTask.cancel()
        }
    }
    
    func showFileWithPath(_ path: String){
        let isFileFound:Bool? = FileManager.default.fileExists(atPath: path)
        if isFileFound == true{
            let viewer = UIDocumentInteractionController(url: URL(fileURLWithPath: path))
            viewer.delegate = self
            viewer.presentPreview(animated: true)
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // Mark URLSessionDownloadDelegate
    
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL){
        
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentDirectoryPath:String = path[0]
        let fileManager = FileManager()
        let destinationURLForFile = URL(fileURLWithPath: documentDirectoryPath + "/offers.json")
        
        if fileManager.fileExists(atPath: destinationURLForFile.path){
            showFileWithPath(destinationURLForFile.path)
        }
        else{
            do {
                try fileManager.moveItem(at: location, to: destinationURLForFile)
                // show file
                showFileWithPath(destinationURLForFile.path)
            }catch{
                print("An error occurred while moving file to destination url")
            }
        }
    }

    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64,
                    totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64){
        progressView.setProgress(Float(totalBytesWritten)/Float(totalBytesExpectedToWrite), animated: true)
    }
    
    
    func urlSession(_ session: URLSession,
                    task: URLSessionTask,
                    didCompleteWithError error: Error?){
        downloadTask = nil
        progressView.setProgress(0.0, animated: true)
        if (error != nil) {
            print("error")
        }else{
            print("The task finished transferring data successfully")
        }
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController{
        return self
    }

    

}

