//
//  AnimalCollectionViewCell.h
//  PetAdoption
//
//  Created by Andrew Kozlik on 10/6/15.
//  Copyright (c) 2015 Andrew Kozlik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>

@interface AnimalCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) IBOutlet PFImageView *imageView;
@property (nonatomic, retain) IBOutlet UILabel *captionLabel;

@end
