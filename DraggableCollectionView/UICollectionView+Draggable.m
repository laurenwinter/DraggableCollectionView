//
//  Copyright (c) 2013 Luke Scott
//  https://github.com/lukescott/DraggableCollectionView
//  Distributed under MIT license
//

#import "UICollectionView+Draggable.h"
#import "LSCollectionViewHelper.h"
#import <objc/runtime.h>

@implementation UICollectionView (Draggable)

- (LSCollectionViewHelper *)getHelper
{
    LSCollectionViewHelper *helper = objc_getAssociatedObject(self, "LSCollectionViewHelper");
    if(helper == nil) {
        helper = [[LSCollectionViewHelper alloc] initWithCollectionView:self];
        objc_setAssociatedObject(self, "LSCollectionViewHelper", helper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return helper;
}

- (BOOL)draggable
{
    return [self getHelper].enabled;
}

- (void)setDraggable:(BOOL)draggable
{
    [self getHelper].enabled = draggable;
}

- (UIEdgeInsets)scrollingEdgeInsets
{
    return [self getHelper].scrollingEdgeInsets;
}

- (void)setScrollingEdgeInsets:(UIEdgeInsets)scrollingEdgeInsets
{
    [self getHelper].scrollingEdgeInsets = scrollingEdgeInsets;
}

- (CGFloat)scrollingSpeed
{
    return [self getHelper].scrollingSpeed;
}

- (void)setScrollingSpeed:(CGFloat)scrollingSpeed
{
    [self getHelper].scrollingSpeed = scrollingSpeed;
}

- (UIView*)destinationView
{
    return [self getHelper].destinationView;
}

- (void)setDestinationView:(UIView *)destinationView
{
    [self getHelper].destinationView = destinationView;
}

- (NSIndexPath*)selectedIndexPath
{
    return [self getHelper].selectedIndexPath;
}

- (void)setSelectedIndexPath:(NSIndexPath*)indexPath
{
    [self getHelper].selectedIndexPath = indexPath;
}

- (void)deleteSelectedCell
{
    [[self getHelper] deleteSelectedCell];
}

- (void)insertAfterSelectedCell
{
    [[self getHelper] insertAfterSelectedCell];
}
@end
