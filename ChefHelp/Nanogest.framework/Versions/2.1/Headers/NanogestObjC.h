#import <Foundation/Foundation.h>
#import "nanogest.h"

typedef enum nanogest_pixel_format NanogestPixelFormat;
typedef enum nanogest_error NanogestError;
typedef enum nanogest_kind NanogestKind;
typedef enum nanogest_config_bits NanogestConfigBits;

@interface NanogestLowLevel : NSObject
{
  @public
  struct nanogest *ngest;
}

- (id)init
    :(uint32_t)width
    :(uint32_t)height
    :(NanogestPixelFormat)pix_format
    :(uint32_t)rotation_counterclockwise_degrees
    :(BOOL)background_thread
    :(BOOL)copy_on_submit;

- (void)change_orientation
    :(uint32_t)rotation_counterclockwise_degrees;

- (uint32_t)get_config;
- (void)update_config
    :(uint32_t)config;

- (void)accept_one_hello
    :(BOOL)enabled;

- (void)submit_frame
    :(const uint8_t *)frame
    :(uint32_t)len
    :(double)time_seconds;

- (void)result_wait;
- (BOOL)result_ready;
- (NanogestKind)result_fetch;
- (void)set_result_callback
    :(nanogest_result_callback)cb
    :(void *)user_data;

- (NanogestError)error_code;
- (NSString *)error_code_name;
- (NSString *)error_msg;

- (BOOL)__diagnostic
    :(BOOL)enabled
    :(uint32_t **)blocks
    :(uint32_t *)width_block
    :(uint32_t *)height_block
    :(char **)msg
    :(uint32_t *)msg_len;

- (NSString *)version_string;
@end
