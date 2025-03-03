#
# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# This is the product configuration for a generic GSM buzz,
# not specialized for any geography.
#

## (1) First, the most specific values, i.e. the aspects that are specific to GSM

PRODUCT_COPY_FILES += \
    device/htc/buzz/init.buzz.rc:root/init.buzz.rc \
    device/htc/buzz/ueventd.buzz.rc:root/ueventd.buzz.rc

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=120 \
    rild.libpath=/system/lib/libhtc_ril.so \
    wifi.interface=eth0 \
    wifi.supplicant_scan_interval=15 \
    ro.ril.ecc.HTC-WWE=999 \
    ro.ril.ecc.HTC-ELL=92,93,94 \
    ro.ril.enable.a52.HTC-ITA=1 \
    ro.ril.enable.a53.HTC-ITA=1 \
    ro.ril.enable.a52=0 \
    ro.ril.enable.a53=1 \
    ro.ril.vmail.23415=1571,BT \
    ro.ril.hsdpa.category=8 \
    ro.ril.htcmaskw1.bitmask=4294967295 \
    ro.ril.htcmaskw1=14449 \
    ro.ril.def.agps.mode=2 \
    ro.ril.gprsclass=12

# Default network type.
# 0 => WCDMA preferred.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.default_network=0

# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=65536

# This is a high density device with more memory, so larger vm heaps for it.
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapsize=24m

## (2) Also get non-open-source GSM-specific aspects if available
$(call inherit-product-if-exists, vendor/htc/buzz/buzz-vendor.mk)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.media.dec.jpeg.memcap=20000000 

# Lock dirty_ratio to 20 when USB is mounted for improved transfer speed
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vold.umsdirtyratio=20

DEVICE_PACKAGE_OVERLAYS += device/htc/buzz/overlay

PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/base/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \

# media config xml file
PRODUCT_COPY_FILES += \
    device/htc/buzz/media_profiles.xml:system/etc/media_profiles.xml \
    device/htc/buzz/bcm4329.hcd:system/etc/firmware/bcm4329.hcd

PRODUCT_PACKAGES += \
    sensors.buzz \
    lights.buzz \
    gralloc.buzz \
    librs_jni \
    gps.buzz \
    copybit.buzz \
    libmm-omxcore \
    libOmxCore \
    libOmxVidEnc \
    com.android.future.usb.accessory

PRODUCT_COPY_FILES += \
    device/htc/buzz/buzz-keypad.kl:system/usr/keylayout/buzz-keypad.kl \
    device/htc/buzz/h2w_headset.kl:system/usr/keylayout/h2w_headset.kl \
    device/htc/buzz/vold.fstab:system/etc/vold.fstab


PRODUCT_COPY_FILES += \
    device/htc/buzz/bcm4329.ko:system/lib/modules/bcm4329.ko

ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/htc/buzz/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

$(call inherit-product-if-exists, vendor/htc/buzz/buzz-vendor.mk)

# stuff common to all HTC phones
$(call inherit-product, device/htc/common/common.mk)
