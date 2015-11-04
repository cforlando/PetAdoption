//
//  ViewController.h
//  PetAdoption
//
//  Created by Andrew Kozlik on 7/9/15.
//  Copyright (c) 2015 Andrew Kozlik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimalListViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, retain) IBOutlet UICollectionView *collectionView;


@end

