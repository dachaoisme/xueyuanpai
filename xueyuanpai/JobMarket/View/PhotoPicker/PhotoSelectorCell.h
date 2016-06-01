//
//  PhotoSelectorCell.h
//  PhotoPicker
//
//  Created by yangtao on 3/1/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoSelectorCell;

@protocol PhotoSelectorCellDelegate <NSObject>

@optional
- (void)photoDidAddSelector: (PhotoSelectorCell*)cell;
- (void)photoDidRemoveSelector: (PhotoSelectorCell*)cell;
@end

@interface PhotoSelectorCell : UICollectionViewCell
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, weak) id<PhotoSelectorCellDelegate> PhotoCelldelegate;
@end
