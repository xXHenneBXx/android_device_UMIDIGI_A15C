#
# Copyright (C) 2025
# SPDX-License-Identifier: Apache-2.0
#

# -------------------------------
# Core product includes
# -------------------------------

# Enable updating of APEX modules
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# A/B OTA
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Shipping API level (Android 15 = API 35)
PRODUCT_SHIPPING_API_LEVEL := 35

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Product characteristics
PRODUCT_CHARACTERISTICS := default

# RRO overlays
PRODUCT_ENFORCE_RRO_TARGETS := *

# -------------------------------
# Boot / Update Engine
# -------------------------------
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier \
    checkpoint_gc \
    otapreopt_script

# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# -------------------------------
# Rootdir / init / fstab files
# -------------------------------
# These are now installed by Android.mk — DO NOT LIST INDIVIDUALLY.
# Leaving them here would cause "duplicate module" or "missing module" errors.
# They are now handled automatically.

# -------------------------------
# HAL packages (only safe ones)
# -------------------------------

# Allocator always exists in AOSP and is safe to include.
PRODUCT_PACKAGES += android.hidl.allocator@1.0-service

# Do NOT include health HAL or boot HAL unless vendor blobs actually provide them.
# The vendor tree for UMIDIGI A15C does NOT include full implementations.
# (This prevents build breaks.)
# If needed later, we add them after auditing vendor blobs.

# -------------------------------
# AB OTA postinstall config
# -------------------------------
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=erofs \
    POSTINSTALL_OPTIONAL_vendor=true

# -------------------------------
# Kernel VINTF — DISABLED because kernel is prebuilt & mismatched
# -------------------------------
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

# -------------------------------
# Build fingerprint (spoofed)
# -------------------------------
PRODUCT_PROPERTY_OVERRIDES += \
    ro.bootimage.build.fingerprint=UMIDIGI/UMIDIGI_A15C/A15C:15/V1.0/xXHenneBXx:eng/test-keys

# -------------------------------
# fstab copy (first stage init)
# -------------------------------
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.ums9230_4h10_go:$(TARGET_VENDOR_RAMDISK_OUT)/first_stage_ramdisk/fstab.ums9230_4h10_go

# -------------------------------
# Soong namespaces
# -------------------------------
PRODUCT_SOONG_NAMESPACES += $(LOCAL_PATH)

# -------------------------------
# Vendor blobs
# -------------------------------
$(call inherit-product, vendor/umidigi/A15C/A15C-vendor.mk)
