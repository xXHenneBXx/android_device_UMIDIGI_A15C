#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl  \ # might need to comment out or fix
    android.hardware.boot@1.2-impl.recovery \ # comment out or fix
    android.hardware.boot@1.2-service # comment out or fix

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

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

PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script

# API levels
PRODUCT_SHIPPING_API_LEVEL := 35

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \ # comment out or fix
    android.hardware.health@2.1-service # comment out or fix

# Overlays
PRODUCT_ENFORCE_RRO_TARGETS := *

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Product characteristics
PRODUCT_CHARACTERISTICS := default

# Rootdir
PRODUCT_PACKAGES += \
    log_to_csv.sh \
    loading.sh \
    para.sh \
    total.sh \
    create_splloader_dual_slot_byname_path.sh \
    init.insmod.sh 


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
    

PRODUCT_PACKAGES += android.hidl.allocator@1.0-service

# Skip Kernel Check For Prebuilt Using Kernel 5.4
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false # comment out for no kernel skip this is used for debugging

PRODUCT_PROPERTY_OVERRIDES += \
    ro.bootimage.build.fingerprint=UMIDIGI/UMIDIGI_A15C/A15C:15/V1.0/xXHenneBXx:eng/test-keys

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.ums9230_4h10_go:$(TARGET_VENDOR_RAMDISK_OUT)/first_stage_ramdisk/fstab.ums9230_4h10_go

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, vendor/umidigi/A15C/A15C-vendor.mk)
