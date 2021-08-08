//
//  UserProfileViewController.swift
//  GloriaAppChallenge
//
//  Created by Martin Regas on 31/07/2021.
//

import UIKit

class UserProfileViewController: BaseViewController {
    
    let MARGIN_COLLECTION_VIEW = CGFloat(10.0)
    let SPACING_CELLS = CGFloat(7.0)
    
    @IBOutlet weak var collectionView:UICollectionView?
    
    lazy var viewModel : UserProfileViewModelContract = {
        let viewModel = UserProfileViewModel(view: self)
        return viewModel
    }()
    
    var userId:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        viewModel.getUserProfile(userId: userId)
    }
    
    func configureCollectionView() {
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(UserVideoCollectionViewCell.self)
        collectionView?.register(UserProfileHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: MARGIN_COLLECTION_VIEW, bottom: MARGIN_COLLECTION_VIEW, right: MARGIN_COLLECTION_VIEW)
        layout.minimumLineSpacing = SPACING_CELLS
        layout.minimumInteritemSpacing = SPACING_CELLS
        collectionView?.collectionViewLayout = layout
    }
}

extension UserProfileViewController: UserProfileViewModelUpdate {
    func updateView() {
        setTitle(title: viewModel.userName().uppercased())
        self.collectionView?.reloadData()
    }
    
    func showLoading() {
        showSpinner(onView: view)
    }
    
    func hideLoading() {
        removeSpinner()
    }
    
    func showError(error:String) {
        let alert = showAlertWith(message: error)
        present(alert, animated: true, completion: nil)
    }
}

extension UserProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.videos().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserVideoCollectionViewCell.identifier, for: indexPath) as? UserVideoCollectionViewCell {
            

            return cell
        }
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: UserProfileHeaderCollectionReusableView.identifier, for: indexPath) as? UserProfileHeaderCollectionReusableView {
            headerView.configureHeader(pictureURL: viewModel.pictureURL(), videosCount: viewModel.videos().count, followersCount: viewModel.followersCount(), followingCount: viewModel.followingCount())
            return headerView
        }
        
        return UICollectionReusableView()
    }
}

extension UserProfileViewController: UICollectionViewDelegate {
    
}

extension UserProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let height = viewModel.profileIsLoadead() ? 264 : 0
        return CGSize(width: collectionView.frame.width, height: CGFloat(height))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 2
              
        let totalSpacing = MARGIN_COLLECTION_VIEW*2 + ((numberOfItemsPerRow - 1)*SPACING_CELLS)
           
        let width = (collectionView.bounds.width - totalSpacing)/numberOfItemsPerRow
     
        return CGSize(width: width, height: collectionView.frame.height/3)
    }
}
