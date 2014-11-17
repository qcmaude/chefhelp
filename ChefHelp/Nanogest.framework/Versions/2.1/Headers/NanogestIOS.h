#import "NanogestObjC.h"
#import "AVFoundation/AVCaptureSession.h"


@protocol NanogestGestureDelegate

- (void) onGesture:(NanogestKind)gesture
         timestamp:(NSTimeInterval)timestamp;

@end

@protocol NanogestErrorDelegate

- (void) onError:(NanogestError)code
        codeName:(NSString *)codeName
         message:(NSString *)message;

@end

@interface Nanogest : NSObject

@property(nonatomic, retain) NanogestLowLevel *ngest;
@property(readonly) BOOL running;
@property(retain) AVCaptureSession *captureSession;
@property(nonatomic) NSUInteger config;

@property(retain) id < NanogestGestureDelegate > gestureDelegate;
@property(retain) id < NanogestErrorDelegate > errorDelegate;

@property(retain) id __diagnosticDelegate;

@property BOOL preventScreenTimeout;

- (id)init;

- (void)start;

- (void)stop;

- (void)mayAcceptOneHelloGesture:(BOOL)yes;

@end
