//
//  SlipPDFLoader.swift
//  Test Views
//
//  Created by Curitiba01 on 03/05/22.
//  Copyright © 2022 Curitiba01. All rights reserved.
//

import Foundation
import PDFKit
import MLKit
import RxSwift

class SlipPDFLoader {
    var image: UIImage?
    
    init(url: URL) {
        guard let document = PDFDocument(url: url),
              let page = document.page(at: 0)
        else { return }

        let pageRect = page.bounds(for: .mediaBox)
        let scale: CGFloat = 3.0
        
        let size = CGSize(width: pageRect.size.width * scale, height: pageRect.size.height * scale)
        
        let renderer = UIGraphicsImageRenderer(size: size)
        self.image = renderer.image { ctx in
            UIColor.white.set()
            
            ctx.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
            ctx.cgContext.translateBy(x: -pageRect.origin.x, y: size.height - pageRect.origin.y)
            ctx.cgContext.scaleBy(x: scale, y: -scale)

            page.draw(with: .mediaBox, to: ctx.cgContext)
        }
    }
    
    func findBarcodeMLKit() -> Observable<[Barcode]?> {
        guard let image = image else { return Observable.just(nil) }
        let visionImage = VisionImage(image: image)
        visionImage.orientation = image.imageOrientation
        let barcodeScanner = BarcodeScanner.barcodeScanner(options: BarcodeScannerOptions(formats: .all))
        return Observable.create { observer in
            barcodeScanner.process(visionImage) { features, error in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(features)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
