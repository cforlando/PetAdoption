//
//  ViewController.m
//  PetAdoption
//
//  Created by Andrew Kozlik on 7/9/15.
//  Copyright (c) 2015 Andrew Kozlik. All rights reserved.
//

#import "AnimalListViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

#import "AnimalCollectionViewCell.h"

@interface AnimalListViewController ()
{
    NSMutableArray *animalsArray;
}
@end

@implementation AnimalListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"City of Lady Lake Animal Services", nil);
    // Do any  additional setup after loading the view, typically from a nib.
    
    [self fetchAnimals];

}

- (void)fetchAnimals
{
    PFQuery *query = [PFQuery queryWithClassName:@"Animal"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
    {
        if (error) {
            // TODO: Error handling
        } else {
            animalsArray = [NSMutableArray arrayWithArray:objects];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }
    }];
}

#pragma mark UICollectionView Data Source and Delegate Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [animalsArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AnimalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnimalCell" forIndexPath:indexPath];
    
    PFObject *animal = [animalsArray objectAtIndex:indexPath.row];
    cell.captionLabel.text = animal[@"name"];

    PFRelation *photos = [animal relationForKey:@"photos"];
    [[photos query] getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error)
    {
        NSLog(@"%@", object);
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.file = object[@"image"];
            [cell.imageView loadInBackground];
        });
    }];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDetails" sender:self];
}

#pragma mark Segue Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showDetails"])
    {

    }
}

#pragma mark - Memory methods
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
