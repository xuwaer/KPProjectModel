//
//  StarLevelView.h
//  HuiZhuang
//
//  Created by mac on 14-9-2.
//
//

#import <UIKit/UIKit.h>

@interface StarLevelView : UIView

@property (nonatomic, assign) BOOL editEnable;

@property (nonatomic, strong) NSString *levelString;

- (id)initWithSelectedImage:(NSString*)selectedImage andHalfSelectedImage:(NSString*)halfSelectedImage andDisableImage:(NSString*)disableImage andFrame:(CGRect)frame andPadding:(float)padding;

- (void)setLevel:(float)level;

- (void)setEditLevel:(float)level;

- (id)initWithFrame:(CGRect)frame numberOfStar:(int)number andselctedImage:(NSString*)selectedImage andUnselectedImage:(NSString*)unselectedImage;


@end
