//
//  MyPhotoBrowser.h
//  MyPhotoBrowser
//  大图侧滑缩放显示
//  Created by Michael Waterfall on 27/04/2015.
//  Copyright savvy.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "MWPhoto.h"
#import "MWPhotoProtocol.h"
#import "MWCaptionView.h"

// Debug Logging
#if 0 // Set to 1 to enable debug logging
#define MWLog(x, ...) DLog(x, ## __VA_ARGS__);
#else
#define MWLog(x, ...)
#endif

@class MyPhotoBrowser;

@protocol MyPhotoBrowserDelegate <NSObject>

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MyPhotoBrowser *)photoBrowser;
- (id <MWPhoto>)photoBrowser:(MyPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index;
- (void)getCurrentMWPhoto:(MWPhoto *)mwPhoto photoAtIndex:(NSUInteger)index;

@optional

- (id <MWPhoto>)photoBrowser:(MyPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index;
- (MWCaptionView *)photoBrowser:(MyPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index;
- (NSString *)photoBrowser:(MyPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index;
- (void)photoBrowser:(MyPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index;
- (void)photoBrowser:(MyPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index;
- (BOOL)photoBrowser:(MyPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index;
- (void)photoBrowser:(MyPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected;
- (void)photoBrowserDidFinishModalPresentation:(MyPhotoBrowser *)photoBrowser;

@end

@interface MyPhotoBrowser : UIViewController <UIScrollViewDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, weak) IBOutlet id<MyPhotoBrowserDelegate> delegate;
@property (nonatomic) BOOL zoomPhotosToFill;
@property (nonatomic) BOOL displayNavArrows;
@property (nonatomic) BOOL displayActionButton;
@property (nonatomic) BOOL displaySelectionButtons;
@property (nonatomic) BOOL alwaysShowControls;
@property (nonatomic) BOOL enableGrid;
@property (nonatomic) BOOL enableSwipeToDismiss;
@property (nonatomic) BOOL startOnGrid;
@property (nonatomic) NSUInteger delayToHideElements;
@property (nonatomic, readonly) NSUInteger currentIndex;

@property(nonatomic, strong) UIButton *collectButton;    //收藏按钮
@property(nonatomic, strong) UIImageView *collectImage;  //收藏图标
@property(nonatomic, strong) NSString *title;    //标题

//图片显示类型，1为可收藏单图，2为可收藏图集（有信息和索引，共用一个收藏标识）,3为不可收藏单图
@property(nonatomic, assign) NSInteger desplayType;
@property(nonatomic, strong) NSString *atlasId;    //图集编号
@property(nonatomic, assign) BOOL atlasFlag;       //图集的收藏标识
@property(nonatomic, strong) NSString *atlasName;  //图集名称
@property(strong, nonatomic) UIView *infoView;          //信息显示布局
@property(strong, nonatomic) UILabel *imageNameLable;   //图片名称
@property(strong, nonatomic) UILabel *imageIndexLable;  //图片索引

// Init
- (id)initWithPhotos:(NSArray *)photosArray  __attribute__((deprecated("Use initWithDelegate: instead"))); // Depreciated
- (id)initWithDelegate:(id <MyPhotoBrowserDelegate>)delegate;

// Reloads the photo browser and refetches data
- (void)reloadData;

// Set page that photo browser starts on
- (void)setCurrentPhotoIndex:(NSUInteger)index;
- (void)setInitialPageIndex:(NSUInteger)index  __attribute__((deprecated("Use setCurrentPhotoIndex: instead"))); // Depreciated

// Navigation
- (void)showNextPhotoAnimated:(BOOL)animated;
- (void)showPreviousPhotoAnimated:(BOOL)animated;

@end
