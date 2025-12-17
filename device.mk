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

PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-impl.recovery \
    android.hardware.boot@1.2-service

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

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service

# Overlays
PRODUCT_ENFORCE_RRO_TARGETS := *

PRODUCT_SHIPPING_API_LEVEL := 33

# Allocator always exists in AOSP and is safe to include.
PRODUCT_PACKAGES += android.hidl.allocator@1.0-service

# -------------------------------
# Kernel VINTF — DISABLED because kernel is prebuilt & mismatched
# -------------------------------
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

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

# system/system_ext policy (platform)
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += \
    device/umidigi/A15C/sepolicy/public

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += \
    device/umidigi/A15C/sepolicy/private

# product / system_ext dumped policy
PRODUCT_PUBLIC_SEPOLICY_DIRS += \
    device/umidigi/A15C/sepolicy/product

PRODUCT_PRIVATE_SEPOLICY_DIRS += \
    device/umidigi/A15C/sepolicy/product

# vendor (includes odm subfolders inside vendor)
VENDOR_SEPOLICY_DIRS += \
    device/umidigi/A15C/sepolicy/vendor

SELINUX_IGNORE_NEVERALLOWS := true
PRODUCT_FULL_TREBLE_OVERRIDE := true

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# -------------------------------
# Vendor blobs
# -------------------------------
$(call inherit-product-if-exists, vendor/gapps/gapps.mk)
$(call inherit-product, vendor/umidigi/A15C/BoardConfig.mk)
