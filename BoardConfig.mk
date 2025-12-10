#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/umidigi/A15C

# A/B
AB_OTA_UPDATER := false
AB_OTA_PARTITIONS += \
    system_ext \
    vendor \
    odm \
    system \
    product \
    vendor_dlkm
BOARD_USES_RECOVERY_AS_BOOT := true

# ENABLES NFC
BOARD_USES_NFC := true

# VENDOR_BOOT
BOARD_USES_VENDOR_BOOT := true
TARGET_USES_VENDOR_BOOTIMAGE := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a75

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := A15C
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 320

# Kernel
BOARD_BOOTIMG_HEADER_VERSION := 4
BOARD_KERNEL_BASE := 0x00000000

# Kernel cmdline: ensure androidboot.hardware matches TARGET_BOARD_PLATFORM
# Adjust console device (ttyHSL0/ttyS1/ttyMSM depending on SoC — replace if necessary)
BOARD_KERNEL_CMDLINE := console=ttyS1,115200n8 androidboot.hardware=ums9230 androidboot.serialno=$(shell getprop ro.serialno) buildvariant=user

BOARD_KERNEL_PAGESIZE := 4096
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_KERNEL_SEPARATED_DTBO := true

# Prebuilt kernel + DTB/DTBO configuration (use stock kernel binary)
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)

# Point to an explicit kernel image file (Image or Image.gz-dtb) inside device tree.
# Replace Image.gz-dtb with the exact filename you extracted (e.g. Image, Image.gz-dtb).
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilts/kernel/Image.gz-dtb

# DTB file (optional if Image.gz-dtb already contains DTB). If your kernel image already
# includes DTB, you can leave TARGET_PREBUILT_DTB empty.
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilts/dtb.img

# If using an Image.gz-dtb (kernel + dtb combined), do NOT pass --dtb separately.
# If using a separate DTB, uncomment the --dtb option below.
#BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)

# If you have a separate DTBO (device tree overlays), provide that file:
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilts/dtbo.img
BOARD_KERNEL_SEPARATED_DTBO := true

# Ensure mkbootimg embeds DTB only if the kernel image does not already include it.
# Set to 'true' to include DTB in bootimg, or leave empty if Image.gz-dtb already contains DTB.
BOARD_INCLUDE_DTB_IN_BOOTIMG := true

endif


# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_DTBOIMG_PARTITION_SIZE := 8388608
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 104857600
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 628023296 # TODO MAY HAVE TO ADJUST
BOARD_SYSTEM_EXTIMAGE_PARTITION_SIZE := 333402112
BOARD_VENDORIMAGE_PARTITION_SIZE := 524283904
BOARD_ODMIMAGE_PARTITION_SIZE := 246194176
BOARD_PRODUCTIMAGE_PARTITION_SIZE := 1535217664
BOARD_VENDOR_DLKMIMAGE_PARTITION_SIZE := 6979584
BOARD_SUPER_PARTITION_SIZE := 3278295040 # TODO MAYBE BIGGER THAN < 6014894080 
BOARD_SUPER_PARTITION_GROUPS := umidigi_dynamic_partitions
BOARD_UMIDIGI_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system_ext \
    vendor \
    odm \
    system \
    product \
    vendor_dlkm

BOARD_UMIDIGI_DYNAMIC_PARTITIONS_SIZE := 3274100736 # TODO MAYBE BIGGER THAN < 5819940723

# Platform
TARGET_BOARD_PLATFORM := ums9230

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_SYSTEM_EXT_PROP += $(DEVICE_PATH)/system_ext.prop
TARGET_SYSTEM_DLKM_PROP += $(DEVICE_PATH)/system_dlkm.prop
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop
TARGET_ODM_DLKM_PROP += $(DEVICE_PATH)/odm_dlkm.prop
TARGET_VENDOR_DLKM_PROP += $(DEVICE_PATH)/vendor_dlkm.prop

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.ums9230_4h10_go
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USERIMAGES_USE_EROFS := true

# Security patch level
VENDOR_SECURITY_PATCH := 2025-02-01

# Build Other Partitions
TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_VENDOR_BOOT := vendor_boot

# Partition Filetypes
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_PARTITION_TYPE := erofs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_PARTITION_TYPE := erofs
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs

# Verified Boot
BOARD_AVB_ENABLE := false
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS +=
#BOARD_AVB_VENDOR_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
#BOARD_AVB_VENDOR_BOOT_ALGORITHM := SHA256_RSA4096
#BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX := 0
#BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX_LOCATION := 0


# VINTF
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest.xml

# Device Vendor Specific Compaitibilty Matrix
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := device/umidigi/A15C/compatibility_matrix.xml 

# Compatibility matrices (add multiple matrices)
BOARD_VINTF_COMPATIBILITY_MATRIX := \
    $(DEVICE_PATH)/rootdir/etc/vintf/compatibility_matrix.3.xml \
    $(DEVICE_PATH)/rootdir/etc/vintf/compatibility_matrix.4.xml \
    $(DEVICE_PATH)/rootdir/etc/vintf/compatibility_matrix.5.xml \
    $(DEVICE_PATH)/rootdir/etc/vintf/compatibility_matrix.6.xml \
    $(DEVICE_PATH)/rootdir/etc/vintf/compatibility_matrix.7.xml

# Add manifest if needed
BOARD_VINTF_MANIFEST := $(LOCAL_PATH)/proprietaries/manifest/manifest.xml

# Inherit the proprietary files
include vendor/umidigi/A15C/BoardConfigVendor.mk
