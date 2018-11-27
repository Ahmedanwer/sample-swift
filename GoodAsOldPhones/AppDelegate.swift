//
//  AppDelegate.swift
//  GoodAsOldPhones
//
//  Copyright © 2016 Code School. All rights reserved.
//

import UIKit
import Instabug


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    Instabug.start(withToken: "d973942f56ac5b73e0a3516a22d7ce5b", invocationEvents: [.shake, .screenshot])

    let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY")
    
    IBGLog.log("Log statement")
    IBGLog.logVerbose("Verbose statement")
    IBGLog.logInfo("Info statement")
    IBGLog.logWarn("Warning statement")
    IBGLog.logDebug("Debug statement")
    IBGLog.logError("Error statement")
    
    Instabug.setUserAttribute("True", withKey: "VIP")
    
    let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
        
        if let data = data {
            do {
                // Convert the data to JSON
                let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                
                if let json = jsonSerialized, let url = json["url"], let explanation = json["explanation"] {
                    print(url)
                    print(explanation)
                }
            }  catch let error as NSError {
                print(error.localizedDescription)
            }
        } else if let error = error {
            print(error.localizedDescription)
        }
    }
    
    task.resume()
    
    // Override point for customization after application launch.
    return true
  }
}
public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    let output = items.map { "\($0)" }.joined(separator: separator)
    
    Swift.print(output, terminator: terminator);
    Instabug.ibgLog(output)
}

