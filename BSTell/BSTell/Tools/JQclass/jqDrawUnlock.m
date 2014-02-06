//
//  PathUnlock.m
//  Sketchpad
//
//  Created by  on 13-5-17.
//  Copyright (c) 2013年 JianQiao. All rights reserved.
//

#import "jqDrawUnlock.h"

@interface jqDrawUnlock (){
@private
    
    CGPoint latestPoint;
    NSMutableArray *allNodes;
    NSMutableArray* paths;
    id _target;
    SEL _action;
    CGSize dotSize;
    NSUInteger row;
    NSUInteger column;
    BOOL touchEnd;
}

- (void)addDotView:(UIView*)view;
- (NSString*)getResult;
@end

@implementation jqDrawUnlock

-(void)setup
{
    for (int i=0; i<row; i++) {
        for (int j=0; j<column; j++) {
            UIImage *dotImage = [UIImage imageNamed:Node_Image_Nornal];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:dotImage highlightedImage:[UIImage imageNamed:Node_Image_Highlighted]];
            imageView.userInteractionEnabled = YES;
            imageView.tag = i*column + j + 1;
            [self addSubview:imageView];
            [imageView release];
        }
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.multipleTouchEnabled = NO;
    if (row<1 || column<1) return;
    
    int w = self.bounds.size.width/column;
    int h = self.bounds.size.height/row;

    int i=0;
    for (UIView *view in self.subviews){
        if ([view isKindOfClass:[UIImageView class]]) {
            
            if (dotSize.width==0.0) {
                dotSize=CGSizeMake(75.0, 75.0);
            }
            view.frame=(CGRect){{0,0},dotSize};
            int x = w*(i%column) + w/2;
            int y = h*(i/column) + h/2;
            view.center = CGPointMake(x, y);

            i++;
        }
    }
}

- (void)drawRect:(CGRect)rect
{
    if ([allNodes count]<1) return;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 6.0);
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {1.0, 0.0, 0.0, 1.0};
    CGColorRef color = CGColorCreate(colorspace, components);
    CGContextSetStrokeColorWithColor(context, color);
    
    CGPoint first=[[allNodes objectAtIndex:0]center];
    CGContextMoveToPoint(context, first.x, first.y);

    for (UIView *dotView in allNodes) {
        CGPoint from = dotView.center;
        CGContextAddLineToPoint(context, from.x, from.y);
    }
    CGRect frame=[[allNodes lastObject]frame];
    if (!touchEnd) {
        if (!CGRectContainsPoint(frame, latestPoint)) {
            CGContextAddLineToPoint(context, latestPoint.x, latestPoint.y);
        }
    }
    
    CGContextStrokePath(context);
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);
    
    latestPoint = CGPointZero;
}
-(void)setTarget:(id)target action:(SEL)action
{
    _target=target;
    _action=action;
}
- (void)addDotView:(UIView *)view {
    if (!allNodes)
        allNodes = [[NSMutableArray alloc]init];
    if (view!=nil) {
        [allNodes addObject:view];
    }
}
-(void)setNodeSize:(CGSize)size
{
    dotSize=size;
    [self setNeedsLayout];
}
-(void)setRow:(NSUInteger)r column:(NSUInteger)c
{
    if (r<1 || c<1) return;
    row=r;
    column=c;
    [self setup];
}
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [paths release];
    paths = [[NSMutableArray alloc] init];
    touchEnd = NO;
}
-(BOOL)touchOnNode:(UIView*)touched
{
    if (touched==self) return NO;
    if (![touched isKindOfClass:[UIImageView class]]) {
        return NO;
    }
    BOOL found = NO;
    for (NSNumber *tag in paths) {
        found = tag.integerValue==touched.tag;
        if (found)
            break;
    }
    
    if (found)
        return YES;
    
    [paths addObject:[NSNumber numberWithInt:touched.tag]];
    [self addDotView:touched];
    
    UIImageView* iv = (UIImageView*)touched;
    iv.highlighted = YES;
    
    return YES;

}
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    latestPoint = [[touches anyObject] locationInView:self];
    
    UIView *touched = [self hitTest:latestPoint withEvent:event];
    [self touchOnNode:touched];
    
    [self setNeedsDisplay];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    latestPoint = [[touches anyObject] locationInView:self];
    
    if (allNodes.count<1) {
        
        UIView *touched = [self hitTest:latestPoint withEvent:event];
        if (![self touchOnNode:touched]) return;

    }else{
        touchEnd = YES;
        [self setNeedsDisplay];
    }
    [_target performSelector:_action withObject:[self getResult]];
}
-(void)reset
{
    latestPoint=CGPointZero;
    touchEnd = NO;
    [allNodes removeAllObjects];
    for (UIView *view in self.subviews)
        if ([view isKindOfClass:[UIImageView class]])
            [(UIImageView*)view setHighlighted:NO];
    [self setNeedsDisplay];
}
- (NSString*)getResult
{
    NSMutableString *key;
    key = [NSMutableString string];

    for (NSNumber *tag in paths) {
        [key appendFormat:@"%d", tag.integerValue];
    }
    return key;
}
-(void)dealloc
{
    [paths release];
    [allNodes release];
    [super dealloc];
}
@end
