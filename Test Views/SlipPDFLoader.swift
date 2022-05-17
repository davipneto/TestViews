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
    var images: [UIImage] = []
    
    init(url: URL, password: String = "") {
        guard let document = PDFDocument(url: url),
              document.unlock(withPassword: password)
        else { return }

        for pageIndex in 0..<document.pageCount {
            guard let page = document.page(at: pageIndex) else { continue }
            let pageRect = page.bounds(for: .mediaBox)
            let scale: CGFloat = 3.5
            
            let size = CGSize(width: pageRect.size.width * scale, height: pageRect.size.height * scale)
            
            let renderer = UIGraphicsImageRenderer(size: size)
            let image = renderer.image { ctx in
                UIColor.white.set()
                
                ctx.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
                ctx.cgContext.translateBy(x: -pageRect.origin.x, y: size.height - pageRect.origin.y)
                ctx.cgContext.scaleBy(x: scale, y: -scale)

                page.draw(with: .mediaBox, to: ctx.cgContext)
            }
            self.images.append(image)
        }
    }
    
    func findBarcodeMLKit() -> Observable<[Barcode]?> {
        return Observable.create { observer in
            for image in self.images {
                let visionImage = VisionImage(image: image)
                visionImage.orientation = image.imageOrientation
                let barcodeScanner = BarcodeScanner.barcodeScanner(options: BarcodeScannerOptions(formats: .all))
                barcodeScanner.process(visionImage) { features, error in
                    if let error = error {
                        observer.onError(error)
                    } else {
                        observer.onNext(features)
                    }
                    if self.images.last == image {
                        observer.onCompleted()
                    }
                }
            }
            return Disposables.create()
        }
    }
}
