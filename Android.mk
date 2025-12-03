#
# Copyright (C) 2025 
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

# Install all rootdir files automatically
include $(CLEAR_VARS)
LOCAL_MODULE := a15c_rootdir_files
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional

# Copy all files from rootdir/ into output
LOCAL_SRC_FILES := \
    $(wildcard $(LOCAL_PATH)/rootdir/etc/*)

# Install to vendor ramdisk if file is fstab
LOCAL_INSTALLED_MODULE_STEM := $(notdir $(LOCAL_SRC_FILES))

# Copy *.rc files to correct locations
$(foreach f,$(filter %.rc,$(LOCAL_SRC_FILES)), \
  $(eval include $(CLEAR_VARS)) \
  $(eval LOCAL_MODULE := $(notdir $(f))) \
  $(eval LOCAL_MODULE_CLASS := ETC) \
  $(eval LOCAL_SRC_FILES := rootdir/etc/$(notdir $(f))) \
  $(eval LOCAL_MODULE_PATH := $(TARGET_VENDOR_ETC)) \
  $(eval include $(BUILD_PREBUILT)) \
)

# Copy *.sh scripts to vendor/bin/
$(foreach f,$(filter %.sh,$(LOCAL_SRC_FILES)), \
  $(eval include $(CLEAR_VARS)) \
  $(eval LOCAL_MODULE := $(notdir $(f))) \
  $(eval LOCAL_MODULE_CLASS := EXECUTABLES) \
  $(eval LOCAL_SRC_FILES := rootdir/etc/$(notdir $(f))) \
  $(eval LOCAL_MODULE_PATH := $(TARGET_VENDOR_EXECUTABLES)) \
  $(eval include $(BUILD_PREBUILT)) \
)

# Copy fstab to first_stage_ramdisk
include $(CLEAR_VARS)
LOCAL_MODULE       := fstab.ums9230_4h10_go
LOCAL_SRC_FILES    := rootdir/etc/fstab.ums9230_4h10_go
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH  := $(TARGET_VENDOR_RAMDISK_OUT)/first_stage_ramdisk
include $(BUILD_PREBUILT)

# Include subdirectories
include $(call all-subdir-makefiles,$(LOCAL_PATH))
