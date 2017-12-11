//
//  BaseViewController.swift
//  AnimationSample
//
//  Created by Innofied on 08/12/17.
//  Copyright © 2017 Innofied. All rights reserved.
//

import UIKit
import SDWebImage
class BaseViewController: UIViewController {

    var dG_indexLabel: DGIndexLabel!
    var dG_imageArray: [Any]! = []
    var dG_collectionView: UICollectionView!
    var dG_closeButton: UIButton!
    var dG_previousButton: DGPreviousButton!
    var dG_nextButton: DGNextButton!
    var dG_index: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dG_indexLabel)
        
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        
        dG_collectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: flowLayout)
        
        dG_collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        dG_collectionView.delegate = self
        dG_collectionView.dataSource = self
        dG_collectionView.isPagingEnabled = true
        dG_collectionView.backgroundColor = UIColor.init(patternImage: #imageLiteral(resourceName: "dg_pattern"))
        self.view.addSubview(dG_collectionView)
        
        let dg_visualEffect = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        dg_visualEffect.frame = CGRect.init(x: 8, y: 20, width: 40, height: 40)
        dg_visualEffect.layer.cornerRadius = 20
        dg_visualEffect.clipsToBounds = true

        self.view.addSubview(dg_visualEffect)

        dG_closeButton = UIButton.init(frame: dg_visualEffect.frame)
        dG_closeButton.setImage(UIImage.init(named: "dg_close"), for: .normal)
        dG_closeButton.addTarget(self, action: #selector(self.closeButtonClicked(button:)), for: .touchUpInside)
        dG_closeButton.tintColor = UIColor.white
        dG_closeButton.layer.cornerRadius = 20
        dG_closeButton.clipsToBounds = true
        self.view.addSubview(dG_closeButton)
        

        let dg_containerView = UIView.init(frame: CGRect.init(x: UIScreen.main.bounds.width/2 - 100, y: UIScreen.main.bounds.height - 70, width: 200, height: 40))
        dg_containerView.layer.cornerRadius = 20
        dg_containerView.clipsToBounds = true

        self.view.addSubview(dg_containerView)
        
        let dg_imageView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        dg_imageView.frame = dg_containerView.bounds
        dg_containerView.addSubview(dg_imageView)
        
        dG_previousButton = DGPreviousButton.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        dG_previousButton.setImage(UIImage.init(named: "dg_left"), for: .normal)
        dG_previousButton.tintColor = UIColor.white
        dG_previousButton.addTarget(self, action: #selector(self.previousButtonClicked(button:)), for: .touchUpInside)
        dg_containerView.addSubview(dG_previousButton)

        dG_nextButton = DGNextButton.init(frame: CGRect.init(x: dg_containerView.frame.size.width - 40, y: 0, width: 40, height: 40))
        dG_nextButton.setImage(UIImage.init(named: "dg_right"), for: .normal)
        dG_nextButton.tintColor = UIColor.white
        dG_nextButton.addTarget(self, action: #selector(self.nextButtonClicked(button:)), for: .touchUpInside)
        dg_containerView.addSubview(dG_nextButton)

        if dG_index == 0 {
            dG_previousButton.isEnabled = false
            dG_previousButton.tintColor = UIColor.darkGray
        }
        else if dG_index == dG_imageArray.count - 1 {
            dG_nextButton.isEnabled = false
            dG_nextButton.tintColor = UIColor.darkGray

        }
        dG_indexLabel = DGIndexLabel.init(frame: CGRect.init(x: dg_containerView.frame.size.width/2 - 35, y: 0, width: 70, height: 40))
        dG_indexLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.init(10))
        dG_indexLabel.formatOfIndex = "%d out of %d"
        dG_indexLabel.setUp(format: "%d out of %d", index: dG_index + 1, totalItems: dG_imageArray.count)
        dG_indexLabel.textColor = UIColor.white
        
        dg_containerView.addSubview(dG_indexLabel)
        
        view.backgroundColor = UIColor.init(white: 1, alpha: 1)
        
        self.dG_collectionView.reloadData()
        dG_collectionView.scrollToItem(at: IndexPath.init(row: dG_index, section: 0), at: .centeredHorizontally, animated: false)
        // Do any additional setup after loading the view.
    }
    
    @objc func closeButtonClicked(button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func nextButtonClicked(button: UIButton) {
        if dG_index < dG_imageArray.count - 1 {
            dG_collectionView.scrollToItem(at: IndexPath.init(row: dG_index + 1, section: 0), at: .centeredHorizontally, animated: true)
            dG_index = dG_index + 1
            self.dG_indexLabel.setUp(index: dG_index + 1, totalItems: self.dG_imageArray.count)
            dG_previousButton.isEnabled = true
            dG_previousButton.tintColor = UIColor.white
            if dG_index == dG_imageArray.count - 1 {
                dG_nextButton.isEnabled = false
                dG_nextButton.tintColor = UIColor.darkGray
            }
        }
    }
    
    @objc func previousButtonClicked(button: UIButton) {
        if dG_index > 0 {
            dG_collectionView.scrollToItem(at: IndexPath.init(row: dG_index - 1, section: 0), at: .centeredHorizontally, animated: true)
            dG_index = dG_index - 1
            self.dG_indexLabel.setUp(index: dG_index + 1, totalItems: self.dG_imageArray.count)
            dG_nextButton.isEnabled = true
            dG_nextButton.tintColor = UIColor.white
            if dG_index == 0 {
                dG_previousButton.isEnabled = false
                dG_previousButton.tintColor = UIColor.darkGray
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pinchedView(sender:UIPinchGestureRecognizer){
        self.view.bringSubview(toFront: sender.view!)
        sender.view?.transform = (sender.view?.transform)!.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1.0
    }

}
extension BaseViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dG_imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let view = cell.viewWithTag(100)
        if view != nil {
            view?.removeFromSuperview()
        }
        let imageView = UIImageView.init(frame: cell.bounds)
        //let textLabel = UILabel.init(frame: cell.bounds)

        if let image = dG_imageArray[indexPath.row] as? UIImage {
            imageView.image = image
        }
        else {
            let urlString = dG_imageArray[indexPath.row] as? String
            imageView.sd_setImage(with: URL.init(string: urlString!), placeholderImage: #imageLiteral(resourceName: "dg_gallery_placeholder"))
        }
        imageView.contentMode = .scaleToFill
        imageView.tag = 100
        cell.addSubview(imageView)
//        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchedView))
//        imageView.isUserInteractionEnabled = true
//        imageView.addGestureRecognizer(pinchGesture)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize.init(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
            self.dG_previousButton.isEnabled = true
            self.dG_previousButton.tintColor = UIColor.white
            self.dG_nextButton.isEnabled = true
            self.dG_nextButton.tintColor = UIColor.white

            let cell = self.dG_collectionView?.visibleCells.first
            let indexPath = self.dG_collectionView?.indexPath(for: cell!)
            self.dG_index = (indexPath?.row)!
            self.dG_indexLabel.setUp(index: (indexPath?.row)! + 1, totalItems: self.dG_imageArray.count)
            if self.dG_index == 0 {
                self.dG_previousButton.isEnabled = false
                self.dG_previousButton.tintColor = UIColor.darkGray
            }
            else if self.dG_index == self.dG_imageArray.count - 1 {
                self.dG_nextButton.isEnabled = false
                self.dG_nextButton.tintColor = UIColor.darkGray
                
            }

        }
    }
    
        
    
}
