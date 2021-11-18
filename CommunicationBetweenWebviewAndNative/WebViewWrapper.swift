//
//  WebViewWrapper.swift
//  CommunicationBetweenWebviewAndNative
//
//  Created by Nitin Bhatia on 10/13/21.
//

import UIKit
import WebKit

protocol WebViewWrapperProtocol {
    func didRecevieMessage(message:String)
}

class WebViewWrapper: WKWebView {
    var delegate : WebViewWrapperProtocol?
    
    func sendDataToWebView(imgData:String){
        
        // nativeProcess here is same as the one defined in the swift code.
        let jsString = "executePromise('\(imgData)')"
        evaluateJavaScript(jsString, completionHandler: {res,erro in
            print("i m res",res)
        })
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setForCommuncationWithNative()
    }
  
}

//extensions for webview
extension WebViewWrapper:WKScriptMessageHandler {
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        self.delegate?.didRecevieMessage(message: "hello")
    }
    
    func setForCommuncationWithNative(){
        self.configuration.userContentController.add(self,name:"nativeProcess")
    }
}

