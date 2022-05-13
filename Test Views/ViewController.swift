//
//  ViewController.swift
//  Test Views
//
//  Created by Curitiba01 on 28/12/20.
//  Copyright © 2020 Curitiba01. All rights reserved.
//

import UIKit
import PDFKit
import MLKit
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
//    private func findBarcodeMLKit(_ image: UIImage) {
//        imageView.image = image
//        let visionImage = VisionImage(image: image)
//        visionImage.orientation = image.imageOrientation
//        let barcodeScanner = BarcodeScanner.barcodeScanner(options: BarcodeScannerOptions(formats: .all))
//        barcodeScanner.process(visionImage) { features, error in
//            guard error == nil, let features = features else {
//                print(error?.localizedDescription)
//                return
//            }
//            if features.isEmpty {
//                print("nenhum codigo de barra encontrado")
//                return
//            }
//            for barcode in features {
//                print("displayValue: \(barcode.displayValue)")
//                print("rawValue: \(barcode.rawValue)")
//                print("type: \(barcode.valueType)")
//                print("format: \(barcode.format)")
//            }
//        }
//    }
//
//    private func loadPDF() {
//        guard let pdfUrl = Bundle.main.url(forResource: "Copel", withExtension: "pdf"),
//              let document = PDFDocument(url: pdfUrl),
//              let page = document.page(at: 0)
//        else { return }
//
//        let pageRect = page.bounds(for: .mediaBox)
//        let scale: CGFloat = 3.0
//
//        let size = CGSize(width: pageRect.size.width * scale, height: pageRect.size.height * scale)
//
//        let renderer = UIGraphicsImageRenderer(size: size)
//        let img = renderer.image { ctx in
//            UIColor.white.set()
//
//            ctx.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
//            ctx.cgContext.translateBy(x: -pageRect.origin.x, y: size.height - pageRect.origin.y)
//            ctx.cgContext.scaleBy(x: scale, y: -scale)
//
//            page.draw(with: .mediaBox, to: ctx.cgContext)
//        }
//        imageView.image = img
//        findBarcodeMLKit(img)
//    }
}

