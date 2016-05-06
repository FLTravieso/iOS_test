//
//  ViewController.swift
//  Movistar
//
//  Created by Frank Travieso on 15/4/16.
//  Copyright © 2016 Wikot. All rights reserved.
//

import UIKit
import Foundation
import Contacts
import CoreData

class ViewController: UIViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(AppDelegate.getAppDelegate().numberSelected)


        
    }
        @IBAction func regexTest() {
             self.performSegueWithIdentifier("hola", sender: self)

    }


    @IBAction func segue(sender: AnyObject) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("Main")
        self.presentViewController(nextViewController, animated:false, completion:nil)
    }


    @IBAction func fetchTable() {
        
        

    }

    @IBAction func webServiceCall(sender: UIButton) {
    
        // prepare json data
//       
//        let customer = ["documentType" : "CI", "documentNumber" : "12741852"]
//        let audit = ["operationId": 112,"userId": "4241465928","applicationId": 25,"operationDate": 14495423,"nodeName": "10.10.10.10"]
//        let payload = ["customer":customer,"audit":audit]
//        let json: [String: AnyObject] = [ "channel": "externalapps" ,"domain": "authentication","serviceName": "GenerateOTP","payload":payload]
   
  
            let jsonTest = "{\"channel\": \"externalapps\",\"domain\": \"authentication\",\"serviceName\": \"GenerateOTP\",\"payload\": {\"audit\": {\"operationId\": 112,\"userId\": \"4241465928\",\"applicationId\": 25,\"operationDate\": 14495423,\"nodeName\": \"10.10.10.10\"},\"customer\":{\"documentType\" : \"CI\",\"documentNumber\" : \"12741852\"}}}"

            print("paso por aca")
//            let jsonData = try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
//            
//            do{
//                if let jsonData2: AnyObject! = try NSJSONSerialization.JSONObjectWithData(jsonData, options:
//                    NSJSONReadingOptions.MutableContainers){
//                        
//                }
//            }catch let caught as NSError{
//                
//                print(caught)
//            }
            let username = "OSBTEST"
            let password = "12345678"
            let loginString = NSString(format: "%@:%@", username, password)
            let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
            let base64LoginString = loginData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
            
            //create post request
            
            let url2 = NSURL(string: "http://10.162.34.158:7003/RSB/REST")!
            let request = NSMutableURLRequest(URL: url2)
            let finalJson = jsonTest.dataUsingEncoding(NSUTF8StringEncoding)
            request.HTTPMethod = "POST"
            request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = finalJson
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data,response,error -> Void in
                if error != nil{
                    print(error?.localizedDescription)
                    return
                }
                let nsdata:NSData = NSData(data:data!)
//                let resstr = NSString(data: nsdata, encoding: NSUTF8StringEncoding)
//                print(nsdata)
//                print(resstr)
                do{
                    if let responseJSON: AnyObject! = try NSJSONSerialization.JSONObjectWithData(nsdata, options:
                        NSJSONReadingOptions.MutableContainers){
                        print("response \(responseJSON)")
                    }
                }catch let caught as NSError{
                
                print(caught)
                }
            }
            
            task.resume()


    }
    
    lazy var contacts: [CNContact] = {
        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName),
            CNContactEmailAddressesKey,
            CNContactPhoneNumbersKey,
            CNContactImageDataAvailableKey,
            CNContactThumbnailImageDataKey]
        
        // Get all the containers
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containersMatchingPredicate(nil)
        } catch {
            print("Error fetching containers")
        }
        
        var results: [CNContact] = []
        
        // Iterate all containers and append their contacts to our results array
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainerWithIdentifier(container.identifier)
            
            do {
                let containerResults = try contactStore.unifiedContactsMatchingPredicate(fetchPredicate, keysToFetch: keysToFetch)
                results.appendContentsOf(containerResults)
            } catch {
                print("Error fetching results for container")
            }
        }
        
        return results
    }()
    
    
    @IBAction func contactsFetch() {
        
        AppDelegate.getAppDelegate().numberSelected = 30
        var movistarContacts = Array<Array<String>>()
        for contact in contacts{
            
            let i = contact.phoneNumbers.count - 1
            for index in 0 ... i{
        
                let value = String(contact.phoneNumbers[index].value)
                let start = value.rangeOfString("digits=")!.endIndex
                let end = value.endIndex.predecessor()
            
                let number = value.substringWithRange(Range<String.Index>(start: start, end: end))
                
                
                if number.hasPrefix("0414") || number.hasPrefix("0424"){
                
                    print(contact.givenName,contact.familyName,"\(number)")
                    
                    let contacto = ["\(contact.givenName) \(contact.familyName)",number]
                    print(contacto)
                    
                    movistarContacts.append(Array(contacto))
                    
                    
                
                }
            }
            

            
            
        }
        
        print(movistarContacts)
        let i = movistarContacts.count - 1
        
        for index in 0 ... i {
        
            print(movistarContacts[index][0],movistarContacts[index][1])
        
        }
        
    }
    

}
