#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#
from extract_utils.file import File
from extract_utils.fixups_blob import BlobFixupCtx, blob_fixup, blob_fixups_user_type
from extract_utils.fixups_lib import lib_fixup_remove, lib_fixups, lib_fixups_user_type
from extract_utils.main import ExtractUtils, ExtractUtilsModule
from extract_utils.tools import llvm_objdump_path
from extract_utils.utils import run_cmd
from extract_utils.source import SourceCtx


namespace_imports = [
    'device/umidigi/A15C',
]

def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}_{partition}' if partition == 'vendor' else None

lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    (
        'libstagefright_foundation',
        'libutils',
    ): lib_fixup_vendor_suffix,
    (
        'libhidltransport',
        'libhwbinder',
    ): lib_fixup_vendor_suffix,
    'libwpa_client': lib_fixup_remove,
}

blob_fixups: blob_fixups_user_type = {
    # Fix Unisoc camera blobs
    'vendor/lib/libcamera_client.so': blob_fixup()
        .add_needed('libshim_camera.so'),
    'vendor/lib/libcamera_metadata.so': blob_fixup()
        .add_needed('libshim_camera.so'),
    
    # Fix Unisoc media blobs
    'vendor/lib/libstagefrighthw.so': blob_fixup()
        .replace_needed('libutils.so', 'libutils-v32.so'),
    
    # Fix Unisoc RIL blobs if present
    'vendor/lib/libril-sprd.so': blob_fixup()
        .replace_needed('libcutils.so', 'libcutils-v29.so'),
    
    # Fix any sensor blobs
    'vendor/lib/hw/sensors.vendor.t606.so': blob_fixup()
        .replace_needed('libutils.so', 'libutils-v32.so'),
    
    # Fix graphics/GPU blobs
    'vendor/lib/egl/libGLES_mali.so': blob_fixup()
        .replace_needed('libutils.so', 'libutils-v32.so'),
}  # fmt: skip

module = ExtractUtilsModule(
    'A15C',
    'umidigi',
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
)

module.add_proprietary_file('proprietary-files.txt')

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()

