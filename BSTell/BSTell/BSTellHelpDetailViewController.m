//
//  BSTellHelpDetailViewController.m
//  BSTell
//
//  Created by cszhan on 14-4-12.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BSTellHelpDetailViewController.h"
#import "BSPreviewScrollView.h"

#define  kImageSize     CGSizeMake(320.f,419)

#define  kIphone4ImageSize   CGSizeMake(320.f,350)

@interface BSTellHelpDetailViewController ()

@property (nonatomic, strong) BSPreviewScrollView *scrollViewPreview;

@end

@implementation BSTellHelpDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.isNeedLogin = NO;
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated{

    self.scrollViewPreview.hidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated{

    self.scrollViewPreview.hidden  = YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setHiddenRightBtn:YES];
    CGFloat currY = kMBAppTopToolBarHeight+10.f;
    CGSize size = kIphone4ImageSize;
    if(kDeviceCheckIphone5){
        size = kImageSize;
    }
    self.scrollViewPreview = [[[BSPreviewScrollView alloc]initWithFrame:CGRectMake(0.f,currY,size.width,size.height)]autorelease];
    NE_LOGRECT(self.scrollViewPreview.frame);
    [self.scrollViewPreview setBackgroundColor:[UIColor clearColor]];
	self.scrollViewPreview.pageSize = size;
	// Important to listen to the delegate methods.
	self.scrollViewPreview.delegate = self;
  
    
    [self.scrollViewPreview setPageViewPendingWidth:0.f];
    [self.scrollViewPreview setPageControlHidden:NO];
    NE_LOGRECT(self.scrollViewPreview.frame);
    StyledPageControl *pageControl = [self.scrollViewPreview getPageControl];
//    UIImage *image  = nil;
//    UIImageWithFileName(image ,@"point-gray.png");
//    pageControl.thumbImage = image;
//    UIImageWithFileName(image ,@"point-red.png");
//    pageControl.selectedThumbImage = image;
    pageControl.pageControlStyle = PageControlStyleStrokedCircle;
    
    CGRect rect = pageControl.frame;
    //[self.scrollViewPreview setPageControlFrame:CGRectMake(0.f,rect.size.height-80.f,kDeviceScreenWidth, 40.f)];
    pageControl.frame = CGRectOffset(rect, 0.f, 10.f);
 
    [self.scrollViewPreview setScrollerZoom:NO];
    [self.view addSubview:self.scrollViewPreview];
    
    
}

#pragma mark -
#pragma mark BSPreviewScrollViewDelegate methods
-(int)itemCount:(BSPreviewScrollView*)scrollView{

    return  self.itemCount;
}
-(UIView*)viewForItemAtIndex:(BSPreviewScrollView*)scrollView index:(int)index
{
	
    UIImage *image  = nil;
    NSString *fileFormart = @"setting_help%d_%02d.png";
    if(kDeviceCheckIphone5){
        fileFormart = @"setting_help%d_%02d-568h@2x.png";
    }
    NSString *fileName  = [NSString stringWithFormat:fileFormart,self.indexType,index+1];
    UIImageWithFileName(image ,fileName);
    assert(image);
    
    CGSize size = kIphone4ImageSize;
    if(kDeviceCheckIphone5){
        size = kImageSize;
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f,size.width,size.height)];
    
    imageView.image = image;
    
    
    return imageView;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
