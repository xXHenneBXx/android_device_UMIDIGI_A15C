#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# A/B support
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Product packages (core)
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier \
    checkpoint_gc \
    otapreopt_script

# API level
PRODUCT_SHIPPING_API_LEVEL := 35

# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Overlays
PRODUCT_ENFORCE_RRO_TARGETS := *

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Product characteristics
PRODUCT_CHARACTERISTICS := default

# Rootdir scripts / files
# If these exist under device/.../rootdir, they should be installed via an Android.mk/Android.bp
# or you should add PRODUCT_COPY_FILES entries below. For now we include them in PRODUCT_PACKAGES
# only if you have defined modules for them.
PRODUCT_PACKAGES += \
    log_to_csv.sh \
    loading.sh \
    para.sh \
    total.sh \
    create_splloader_dual_slot_byname_path.sh \
    init.insmod.sh

# Add init and fstab files (these must exist in rootdir and be packaged)
PRODUCT_PACKAGES += \
    fstab.ums9230_4h10_go \
    init.cali.rc \
    init.g2315guf_v1_gc_ym_a15c_t.rc \
    init.g2315guf_v1_gc_ym_a15c_t.usb.rc \
    init.ram.gms.rc \
    init.ram.native.rc \
    init.ram.rc \
    init.stnfc.rc \
    init.storage.rc \
    init.ums9230_1h10.rc \
    init.ums9230_1h10.usb.rc \
    init.ums9230_1h10_go.rc \
    init.ums9230_1h10_go.usb.rc \
    init.ums9230_4h10.rc \
    init.ums9230_4h10.usb.rc \
    init.ums9230_4h10_go.rc \
    init.ums9230_4h10_go.usb.rc \
    init.ums9230_6h10.rc \
    init.ums9230_6h10.usb.rc \
    init.ums9230_7h10.rc \
    init.ums9230_7h10.usb.rc \
    init.ums9230_haps.rc \
    init.ums9230_haps.usb.rc \
    init.ums9230_zebu.rc \
    init.ums9230_zebu.usb.rc

# HIDL / HAL packages - include conditionally to avoid hard failures if vendor does not provide them.
# For each HAL package, ensure the corresponding module exists under vendor or is provided by vendor/ prebuilts.
# Example conditional inclusion for android.hardware.boot@1.2:
ifeq ($(wildcard $(LOCAL_PATH)/../vendor/umidigi/A15C/*android.hardware.boot*),)
# no vendor-provided boot HIDL impl found - skip
else
PRODUCT_PACKAGES += android.hardware.boot@1.2-impl
PRODUCT_PACKAGES += android.hardware.boot@1.2-impl.recovery
PRODUCT_PACKAGES += android.hardware.boot@1.2-service
endif

# Example conditional inclusion for health HAL
ifeq ($(wildcard $(LOCAL_PATH)/../vendor/umidigi/A15C/*health*),)
# skip health HALs if not present
else
PRODUCT_PACKAGES += android.hardware.health@2.1-impl
PRODUCT_PACKAGES += android.hardware.health@2.1-service
endif

# Example: android.hidl.allocator
# Only add it if the module exists in vendor/system. This avoids missing module errors.
ifeq ($(wildcard $(LOCAL_PATH)/../vendor/umidigi/A15C/**/*allocator*),)
else
PRODUCT_PACKAGES += android.hidl.allocator@1.0-service
endif

# AB OTA postinstall config
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

# If you used a prebuilt kernel and need to skip the kernel VINTF check for development, keep false during testing
# WARNING: set this to true for releases if you need to enforce kernel VINTF requirements
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

# Product properties override
PRODUCT_PROPERTY_OVERRIDES += \
    ro.bootimage.build.fingerprint=UMIDIGI/UMIDIGI_A15C/A15C:15/V1.0/xXHenneBXx:eng/test-keys

# Copy fstab into first-stage ramdisk (example)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.ums9230_4h10_go:$(TARGET_VENDOR_RAMDISK_OUT)/first_stage_ramdisk/fstab.ums9230_4h10_go

# Soong namespace for device-specific modules
PRODUCT_SOONG_NAMESPACES += $(LOCAL_PATH)

# Inherit the proprietary files from vendor
$(call inherit-product, vendor/umidigi/A15C/A15C-vendor.mk)
