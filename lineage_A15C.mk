#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from A15C device
$(call inherit-product, device/umidigi/A15C/device.mk)

PRODUCT_DEVICE := A15C
PRODUCT_NAME := lineage_A15C
PRODUCT_BRAND := UMIDIGI
PRODUCT_MODEL := MP34
PRODUCT_MANUFACTURER := umidigi

PRODUCT_GMS_CLIENTID_BASE := android-sunvov

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="UMIDIGI_A15C_V1.0_20240314"

BUILD_FINGERPRINT := UMIDIGI/UMIDIGI_A15C/UMIDIGI_A15C:13/TP1A.220624.014/2306241037:user/release-keys
