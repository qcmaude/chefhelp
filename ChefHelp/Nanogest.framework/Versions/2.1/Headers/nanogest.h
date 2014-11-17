#ifndef NANOGEST_H__
#define NANOGEST_H__

#include <stdint.h>

#if (defined __GNUC__)
# if __GNUC__ >= 4
#  define EXPORT __attribute__((visibility("default")))
# else
#  error "Cannot unhide API symbols"
# endif
#elif (defined __WIN32__)
# define EXPORT __declspec(dllexport)
#endif

#define NANOGEST_API_VERSION 1

struct nanogest;

EXPORT
struct nanogest *nanogest_new();
EXPORT
void nanogest_delete(struct nanogest *ngest);

enum nanogest_pixel_format {
  NANOGEST_PIXEL_FORMAT_NV12 = 1,
  NANOGEST_PIXEL_FORMAT_420YpCbCr8BiPlanar = NANOGEST_PIXEL_FORMAT_NV12,
  NANOGEST_PIXEL_FORMAT_NV21 = 2,
  NANOGEST_PIXEL_FORMAT_I420 = 3,
  NANOGEST_PIXEL_FORMAT_LUMA = 4,
  NANOGEST_PIXEL_FORMAT_GRAYSCALE = 5,
};

enum nanogest_error {
  NANOGEST_OK = 0,
  NANOGEST_ERROR_ALLOC = 1,
  NANOGEST_ERROR_INVALID_ARGUMENT = 2,
  NANOGEST_ERROR_OS = 3,
  NANOGEST_ERROR_DISABLED = 4,
  NANOGEST_ERROR_UNKNOWN = 5,
  NANOGEST_ERROR__NUM,
};

enum nanogest_kind {
  NANOGEST_NONE = 0,
  NANOGEST_SWIPE_LEFT = 1,
  NANOGEST_SWIPE_RIGHT = 2,
  NANOGEST_SWIPE_UP = 3,
  NANOGEST_SWIPE_DOWN = 4,
  NANOGEST_HELLO = 5,
  NANOGEST_COVERED = 6,
  NANOGEST_UNCOVERED = 7,
  NANOGEST_BACKWARD = 8,
  NANOGEST_FORWARD = 9,
};

enum nanogest_config_bits {
  NANOGEST_CONFIG_DEFAULT = 0,
  NANOGEST_CONFIG_NORMAL_RANGE = 0,
  NANOGEST_CONFIG_CLOSE_RANGE = 0x1,
};

EXPORT
void nanogest_init(struct nanogest *ngest,
                   uint32_t width, uint32_t height,
                   enum nanogest_pixel_format pix_format,
                   uint32_t rotation_counterclockwise_degrees,
                   int background_thread, int copy_on_submit,
                   void *reserved);

/*
 * No-op if the orientation already set is identical to the argument
 * 'rotation_counterclockwise_degrees'.
 */
// May block.
EXPORT
void nanogest_change_orientation(struct nanogest *ngest,
                                 uint32_t rotation_counterclockwise_degrees);

EXPORT
uint32_t nanogest_get_config(struct nanogest *ngest);

// May block.
EXPORT
void nanogest_update_config(struct nanogest *ngest, uint32_t config);

// May block.
EXPORT
void nanogest_accept_one_hello(struct nanogest *ngest, int enabled);

EXPORT
void nanogest_submit_frame(struct nanogest *ngest,
                           const uint8_t *frame, uint32_t len,
                           double time_seconds);
EXPORT
void nanogest_result_wait(struct nanogest *ngest);
EXPORT
int nanogest_result_ready(struct nanogest *ngest);

typedef void (*nanogest_result_callback)(struct nanogest *ngest,
                                         enum nanogest_kind kind,
                                         double time_s,
                                         void *user_data);

EXPORT
void nanogest_set_result_callback(struct nanogest *ngest,
                                  nanogest_result_callback cb,
                                  void *user_data);

EXPORT
enum nanogest_kind nanogest_result_fetch(struct nanogest *ngest);

EXPORT
enum nanogest_error nanogest_error_code(struct nanogest *ngest);
EXPORT
const char *nanogest_error_code_name(struct nanogest *ngest);
EXPORT
const char *nanogest_error_msg(struct nanogest *ngest);

typedef void (*nanogest_error_callback)(struct nanogest *ngest);

EXPORT
int __nanogest_diagnostic(struct nanogest *ngest,
                          int enabled,
                          uint32_t **blocks, uint32_t *width_block, uint32_t *height_block,
                          char **msg, uint32_t *msg_len);

EXPORT
const char *__nanogest_commit;
EXPORT
const char *nanogest_version_string(struct nanogest *ngest);

#undef EXPORT

#endif
