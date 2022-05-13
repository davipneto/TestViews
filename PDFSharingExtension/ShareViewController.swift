//
//  ShareViewController.swift
//  PDFSharingExtension
//
//  Created by Curitiba01 on 28/04/22.
//  Copyright © 2022 Curitiba01. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
//        self.openURL(URL(string: "mytestapp:openpdf")!)
        self.loadFile()
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }
    
    private func loadFile() {
        if let attachments = (self.extensionContext?.inputItems.first as? NSExtensionItem)?.attachments {
            let contentType = kUTTypeData as String
            for attachment in attachments {
                if attachment.hasItemConformingToTypeIdentifier(contentType) {
                    attachment.loadItem(forTypeIdentifier: contentType, options: nil) { (data, error) in
                        guard error == nil else { return }
                        if let url = data as? URL,
                           let defaults = UserDefaults(suiteName: "group.davi.testpdf"){
                            defaults.set(url, forKey: "slipPdf")
                        }
                        self.openURL(URL(string: "mytestapp:openPdf")!)
                        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
                    }
                }
            }
        }
    }
    
    @objc func openURL(_ url: URL) -> Bool {
        var responder: UIResponder? = self
        while responder != nil {
            if let application = responder as? UIApplication {
                return application.perform(#selector(openURL(_:)), with: url) != nil
            }
            responder = responder?.next
        }
        return false
    }

}
