#import <UIKit/UIKit.h>

@interface NanogestPage : NSObject
@property(readonly) UIView *view;

- (id)initWithView:(UIView *)v;
- (void)prepareToPlay;
- (void)play;
- (void)pause;
- (void)stop;
@end

// URLs must be globally unique, across the whole set of stories and pages.
typedef void (^NanogestURLBlock)(NSString *url);
typedef void (^NanogestPageBlock)(NanogestPage *page);
typedef void (^NanogestNotifyBlock)();
typedef void (^NanogestAnimationsBlock)();

@protocol NanogestStoriesViewSource < NSObject >
- (void)notifyWhenContentAvailableWithBlock:(NanogestNotifyBlock)notifyBlock;
- (void)getStoriesUsingBlock:(NanogestURLBlock)storyURLBlock;
- (void)getPagesForStory:(NSString *)storyURL
              usingBlock:(NanogestURLBlock)pageURLBlock;
- (void)loadPage:(NSString *)url
       withFrame:(CGRect)frame
      usingBlock:(NanogestPageBlock)pageBlock;
- (void)loadPageThumbnail:(NSString *)url
                withFrame:(CGRect)frame
               usingBlock:(NanogestPageBlock)pageBlock;

@optional
- (void)checkpoint__:(NSString *)name;
@end

@interface NanogestStoriesViewController : UIViewController
- (id)initWithViewSource:(id<NanogestStoriesViewSource>)source;
- (void)setBackground:(UIView *)bg forLevel:(int)level;
- (void)setForeground:(UIView *)bg forLevel:(int)level;
@end
