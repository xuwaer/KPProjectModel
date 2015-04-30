//
//  StarLevelView.m
//  HuiZhuang
//
//  Created by mac on 14-9-2.
//
//

#import "StarLevelView.h"

@interface StarLevelView()
{
    NSMutableArray *imageArray;
    
    NSString *_selectedImage;
    NSString *_halfSelectedImage;
    NSString *_disableImage;
    
    int numberOfStar;
}

@property (nonatomic, strong) UIView *starBackgroundView;
@property (nonatomic, strong) UIView *starForegroundView;

@end

@implementation StarLevelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (id)initWithSelectedImage:(NSString*)selectedImage andHalfSelectedImage:(NSString*)halfSelectedImage andDisableImage:(NSString*)disableImage andFrame:(CGRect)frame andPadding:(float)padding
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        imageArray = [[NSMutableArray alloc] init];
        
        _selectedImage = selectedImage;
        _halfSelectedImage = halfSelectedImage;
        _disableImage = disableImage;

        for(int i = 1; i <= 5; i++)
        {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:disableImage]];
            imageView.frame = RectSetX(imageView.frame, (i-1)*(padding + RectWidth(imageView.frame)));
            self.frame = Rect(RectX(frame), 0, RectWidth(imageView.frame)*5 + (5 - 1) * padding, RectHeight(imageView.frame));
            [imageArray addObject:imageView];
            [self addSubview:imageView];
        }

    }
    
    return self;
}

- (void)setLevel:(float)level
{
    for (int i = 1; i <= [imageArray count]; i++)
    {
        UIImageView *imageView = [imageArray objectAtIndex:i-1];
        if (level >= i)
        {
            imageView.image = [UIImage imageNamed:_selectedImage];
        }
        else if (level < i && level > (i-1))
        {
            imageView.image = [UIImage imageNamed:_halfSelectedImage];
        }
        else if(level <= (i-1))
        {
            imageView.image = [UIImage imageNamed:_disableImage];
        }
    }
}

- (void)setEditLevel:(float)level
{
    self.starForegroundView.frame = CGRectMake(0, 0, level/numberOfStar *self.frame.size.width, self.frame.size.height);
}

- (id)initWithFrame:(CGRect)frame numberOfStar:(int)number andselctedImage:(NSString*)selectedImage andUnselectedImage:(NSString*)unselectedImage
{
    self = [super initWithFrame:frame];
    if (self) {
        numberOfStar = number;
        self.starBackgroundView = [self buidlStarViewWithImageName:unselectedImage];
        self.starForegroundView = [self buidlStarViewWithImageName:selectedImage];
        [self addSubview:self.starBackgroundView];
        [self addSubview:self.starForegroundView];
    }
    return self;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if(CGRectContainsPoint(rect,point) && self.editEnable)
    {
        [self changeStarForegroundViewWithPoint:point];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.editEnable) return;
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];

    __weak typeof(self) weakSelf = self;
    [UIView transitionWithView:self.starForegroundView
                      duration:0.2
                       options:UIViewAnimationOptionCurveEaseInOut
                    animations:^
     {
         [weakSelf changeStarForegroundViewWithPoint:point];
     }
        completion:^(BOOL finished)
     {
         
     }];
}

- (UIView *)buidlStarViewWithImageName:(NSString *)imageName
{
    CGRect frame = self.bounds;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.clipsToBounds = YES;
    for (int i = 0; i < numberOfStar; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * frame.size.width / numberOfStar + (frame.size.width / numberOfStar - RectWidth(imageView.frame)) / 2, 0, RectWidth(imageView.frame), frame.size.height);
        [view addSubview:imageView];
    }
    return view;
}

- (void)changeStarForegroundViewWithPoint:(CGPoint)point
{
    CGPoint p = point;
    
    if (p.x < 0)
    {
        p.x = 0;
    }
    else if (p.x > self.frame.size.width)
    {
        p.x = self.frame.size.width;
    }
    
    NSString * str = [NSString stringWithFormat:@"%0.2f",p.x / self.frame.size.width];
    float score = [str floatValue] * 5;
    if(score > floorf(score) && score < (ceilf(score) - 0.5)) score = floorf(score) + 0.5;
    if(score > (floorf(score) + 0.5) && score < ceilf(score)) score = ceilf(score);
    self.levelString = [NSString stringWithFormat:@"%0.1f",score];
    p.x = score/5 * self.frame.size.width;
    self.starForegroundView.frame = CGRectMake(0, 0, p.x, self.frame.size.height);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
