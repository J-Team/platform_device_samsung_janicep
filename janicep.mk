# Include common makefile
$(call inherit-product, device/samsung/u8500-common/common.mk)

# Use non-open-source parts if present
$(call inherit-product-if-exists, vendor/samsung/u8500-common/janice/janicep-vendor-blobs.mk)


LOCAL_PATH := device/samsung/janicep
JANICE_PATH := device/samsung/janice

# Overlay
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# STE
PRODUCT_COPY_FILES += \
    $(JANICE_PATH)/configs/ste_modem.sh:system/etc/ste_modem.sh

# Tee
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/tee/cops_ta.ssw:system/lib/tee/cops_ta.ssw \
    $(LOCAL_PATH)/tee/custom_ta.ssw:system/lib/tee/custom_ta.ssw \
    $(LOCAL_PATH)/tee/libbassapp_ssw:system/lib/tee/libbassapp_ssw \
    $(LOCAL_PATH)/tee/smcl_ta_8500bx_secure.ssw:system/lib/tee/smcl_ta_8500bx_secure.ssw
    
# Enable AAC 5.1 output
PRODUCT_PROPERTY_OVERRIDES += \
    media.aac_51_output_enabled=true

# Packages
PRODUCT_PACKAGES += \
    	GalaxySAdvanceSettings
    	
# GPS
PRODUCT_COPY_FILES += \
    $(JANICE_PATH)/configs/gps.conf:system/etc/gps.conf \
    $(JANICE_PATH)/configs/sirfgps.conf:system/etc/sirfgps.conf
    
# Compass workaround
PRODUCT_COPY_FILES += \
    $(JANICE_PATH)/configs/compass:system/etc/init.d/compass

$(call inherit-product, device/common/gps/gps_eu_supl.mk)

# NFCEE access control
ifeq ($(TARGET_BUILD_VARIANT),user)
	NFCEE_ACCESS_PATH := device/samsung/janicep/NFC/nfcee_access.xml
else
	NFCEE_ACCESS_PATH := device/samsung/janicep/NFC/nfcee_access_debug.xml
endif
PRODUCT_COPY_FILES += \
	$(NFCEE_ACCESS_PATH):system/etc/nfcee_access.xml

# Init files
PRODUCT_COPY_FILES += \
    $(JANICE_PATH)/rootdir/fstab.samsungjanice:root/fstab.samsungjanicep \
    $(LOCAL_PATH)/rootdir/init.samsungjanicep.rc:root/init.samsungjanice.rc \
    $(JANICE_PATH)/rootdir/init.samsungjanice.usb.rc:root/init.samsungjanicep.usb.rc \
    $(JANICE_PATH)/rootdir/init.recovery.samsungjanice.rc:root/init.recovery.samsungjanicep.rc \
    $(JANICE_PATH)/rootdir/ueventd.samsungjanice.rc:root/ueventd.samsungjanicep.rc
    
# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml

# Audio
PRODUCT_COPY_FILES += \
    $(JANICE_PATH)/configs/adm.sqlite-u8500:system/etc/adm.sqlite-u8500 \
    $(JANICE_PATH)/configs/audio_policy.conf:system/vendor/etc/audio_policy.conf \
    $(JANICE_PATH)/configs/audio_policy.conf:system/etc/audio_policy.conf \
    
# Storage switch script
PRODUCT_COPY_FILES += \
   $(JANICE_PATH)/configs/SwapStorages.sh:system/xbin/SwapStorages.sh
PRODUCT_PROPERTY_OVERRIDES += \
   persist.sys.vold.switchablepair=sdcard0,sdcard1 \
   persist.sys.vold.switchexternal=0

# RIL
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/configs/manuf_id.cfg:system/etc/AT/manuf_id.cfg \
   $(LOCAL_PATH)/configs/model_id.cfg:system/etc/AT/model_id.cfg \
   $(LOCAL_PATH)/configs/system_id.cfg:system/etc/AT/system_id.cfg

# NFC
PRODUCT_PACKAGES += \
        com.android.nfc_extras \
	libnfc \
	libnfc_jni \
	Nfc \
	Tag
PRODUCT_COPY_FILES += \
	packages/apps/Nfc/migrate_nfc.txt:system/etc/updatecmds/migrate_nfc.txt \
	frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml \
        frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
	frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml
