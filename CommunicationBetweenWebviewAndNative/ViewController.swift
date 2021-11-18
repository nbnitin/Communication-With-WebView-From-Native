//
//  ViewController.swift
//  CommunicationBetweenWebviewAndNative
//
//  Created by Nitin Bhatia on 10/13/21.
//

import UIKit
import WebKit

class ViewController: UIViewController,WebViewWrapperProtocol{
    
    //outlets
    @IBOutlet var webView: WebViewWrapper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = Bundle.main.url(forResource: "Test", withExtension: "html") {
            webView.load(URLRequest(url: url))
        }
        webView.delegate = self
    }
    
    //MARK: did recevie function it been called once button pressed in webview
    func didRecevieMessage(message: String) {
        print(message)
        let imgData = captureScreen()?.pngData()?.base64EncodedString()
        webView.sendDataToWebView(imgData: imgData ?? "")
    }
    
    //MARK: captures the screenshot
    func captureScreen() -> UIImage? {
        var screenshotImage :UIImage?
               let scale = UIScreen.main.scale

               let layer = UIApplication.shared.keyWindow!.layer
               UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);

               //If you don't want the Navigation Bar
               //let layer = self.view.layer
               //UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);

               let context = UIGraphicsGetCurrentContext()!
               layer.render(in:context)
               screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
               UIGraphicsEndImageContext()
        return screenshotImage
        
//        if let snapView = UIApplication.shared.keyWindow?.snapshotView(afterScreenUpdates: false) {
        //no more avialable
        //let statusBar = UIApplication.shared.value(forKey: "statusBarWindow") as? UIWindow

//            if let statusBarSnapView = (UIApplication.shared.keyWindow?.windowScene?.statusBarManager as?  UIView)?.snapshotView(afterScreenUpdates: false) {
//                snapView.addSubview(statusBarSnapView)
//            }
//            UIGraphicsBeginImageContextWithOptions(snapView.bounds.size, true, 0)
//            snapView.drawHierarchy(in: snapView.bounds, afterScreenUpdates: true)
//            let snapImage = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            return snapImage
//        }
//        return nil
    }
}

