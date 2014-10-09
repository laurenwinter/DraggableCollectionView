//
//  Copyright (c) 2013 Luke Scott
//  https://github.com/lukescott/DraggableCollectionView
//  Distributed under MIT license
//

#import "ViewController.h"
#import "Cell.h"

#define SECTION_COUNT 5
#define ITEM_COUNT 20

@interface ViewController ()
{
    NSMutableArray *sections;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //_collectionView.destinationView = self.view;
    sections = [[NSMutableArray alloc] initWithCapacity:ITEM_COUNT];
    for(int s = 0; s < SECTION_COUNT; s++) {
        NSMutableArray *data = [[NSMutableArray alloc] initWithCapacity:ITEM_COUNT];
        for(int i = 0; i < ITEM_COUNT; i++) {
            [data addObject:[NSString stringWithFormat:@"%c %@", 65+s, @(i)]];
        }
        [sections addObject:data];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[sections objectAtIndex:section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Cell *cell = (Cell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    NSMutableArray *data = [sections objectAtIndex:indexPath.section];
    
    cell.label.text = [data objectAtIndex:indexPath.item];
    cell.backgroundColor = [UIColor orangeColor];
    
    return cell;
}

- (BOOL)collectionView:(LSCollectionViewHelper *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath
{
// Prevent item from being moved to index 0
//    if (toIndexPath.item == 0) {
//        return NO;
//    }
    return YES;
}

- (void)collectionView:(LSCollectionViewHelper *)collectionView moveItemAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSMutableArray *data1 = [sections objectAtIndex:fromIndexPath.section];
    NSMutableArray *data2 = [sections objectAtIndex:toIndexPath.section];
    NSString *index = [data1 objectAtIndex:fromIndexPath.item];
    
    [data1 removeObjectAtIndex:fromIndexPath.item];
    [data2 insertObject:index atIndex:toIndexPath.item];
}

- (UIImageView *)collectionView:(UICollectionView *)collectionView createMockCell:(NSIndexPath *)indexPath {
    Cell *cell = (Cell*)[collectionView cellForItemAtIndexPath:indexPath];
    UIImageView *mockCell = [[UIImageView alloc] initWithFrame:cell.frame];
    mockCell.image = [self imageFromCell:cell];
    
    // Add the delete button
    UIImageView *deleteControl = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 36.0, 36.0)];
    deleteControl.backgroundColor = [UIColor clearColor];
    deleteControl.image = [UIImage imageNamed:@"editor-delete-sticker"];
    deleteControl.userInteractionEnabled = YES;
    UITapGestureRecognizer * deleteTap = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(deleteTapHandler:)];
    [deleteControl addGestureRecognizer:deleteTap];
    [mockCell addSubview:deleteControl];
    
    // Add the duplicate button
    UIImageView *duplicateControl = [[UIImageView alloc]initWithFrame:CGRectMake(mockCell.frame.size.width - 36.0, 0, 36.0, 36.0)];
    duplicateControl.backgroundColor = [UIColor clearColor];
    duplicateControl.image = [UIImage imageNamed:@"editor-duplicate-tool"];
    duplicateControl.userInteractionEnabled = YES;
    UITapGestureRecognizer * duplicateTap = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(duplicateTapHandler:)];
    [duplicateControl addGestureRecognizer:duplicateTap];
    [mockCell addSubview:duplicateControl];
    return mockCell;
}

- (void)deleteTapHandler:(UITapGestureRecognizer *)sender
{
    // First, delete the cell data
    NSIndexPath *selectedPath = _collectionView.selectedIndexPath;
    [sections[selectedPath.section] removeObjectAtIndex:selectedPath.row];
    
    // Update the collection view
    [self.collectionView deleteSelectedCell];
}

- (void)duplicateTapHandler:(UITapGestureRecognizer *)sender
{
    NSIndexPath *selectedPath = _collectionView.selectedIndexPath;
    NSMutableArray *sectionData = [sections objectAtIndex:selectedPath.section];
    
    // Copy and insert the cell data
    NSString *cellData = [NSString stringWithFormat:@"%@ copy", [sectionData objectAtIndex:selectedPath.item]];
    [sectionData insertObject:cellData atIndex:selectedPath.row+1];
    
    // Update the collection view
    [self.collectionView insertAfterSelectedCell];
}

- (UIImage *)imageFromCell:(UICollectionViewCell *)cell {
    UIGraphicsBeginImageContextWithOptions(cell.bounds.size, NO, 1.0);
    [cell.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
