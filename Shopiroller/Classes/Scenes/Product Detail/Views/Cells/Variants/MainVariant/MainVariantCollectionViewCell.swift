//
//  MainVariantCollectionViewCell.swift
//  Braintree
//
//  Created by Görkem Gür on 11.01.2023.
//

import UIKit


protocol MainVariantDelegate {
    func childVariantClicked(variantIndex: Int?, variantGroupIndex: Int?)
}

class MainVariantCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var headerTitleLabel: UILabel!
    
    @IBOutlet private weak var childVariantCollectionView: UICollectionView!
    
    private var variantSelectionList: [VariantSelectionModel]?
    
    private var delegate: MainVariantDelegate?
    
    private var variantGroupIndex: Int?
    
    private var isBase: Bool? = false
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        childVariantCollectionView.register(cellClass: ChildVariantCollectionViewCell.self)
        childVariantCollectionView.delegate = self
        childVariantCollectionView.dataSource = self
        childVariantCollectionView.allowsMultipleSelection = false
    }
    
    func setup(list: [VariantSelectionModel]?, variantGroupIndex: Int?, delegate: MainVariantDelegate?) {
        self.delegate = delegate
        self.variantSelectionList = list
        self.variantGroupIndex = variantGroupIndex
        
        headerTitleLabel.text = list?[variantGroupIndex ?? 0].variantGroupName
        
        self.childVariantCollectionView.reloadData()
    }

}

extension MainVariantCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return variantSelectionList?[variantGroupIndex ?? 0].variationList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChildVariantCollectionViewCell.reuseIdentifier, for: indexPath) as! ChildVariantCollectionViewCell
        
        if (variantGroupIndex == 0) {
            isBase = true
        } else {
            isBase = false
        }
        
        cell.setup(model: variantSelectionList?[variantGroupIndex ?? 0].variationList?[indexPath.row] ?? Variation(), isLayoutGroupActive: variantSelectionList?[variantGroupIndex ?? 0].variantGroupIsActive ?? false, isBaseVariantGroup: isBase ?? false)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.childVariantClicked(variantIndex: indexPath.row, variantGroupIndex: variantGroupIndex)
    }
    
}

extension MainVariantCollectionViewCell: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGFloat(35)
        if (variantSelectionList?[variantGroupIndex ?? 0].variationList?[indexPath.item].value?.count ?? 0 > 1) {
            size += 10
        }
        return CGSize(width: (variantSelectionList?[variantGroupIndex ?? 0].variationList?[indexPath.item].value?.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]).width ?? 0) + size, height: 50)
    }
}
