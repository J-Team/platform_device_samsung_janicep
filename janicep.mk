# Include common makefile
$(call inherit-product, device/samsung/u8500-common/common.mk)

ifneq ($(TARGET_SCREEN_HEIGHT),800)
# Call cm.mk because somehow it's not being called!
$(call inherit-product, device/samsung/janice/cm.mk)
endif


LOCAL_PATH := device/samsung/janicep

# Overlay
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# This device is HDPI
PRODUCT_AAPT_CONFIG := normal hdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi

# Tee
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/tee/cops_ta.ssw:system/lib/tee/cops_ta.ssw \
    $(LOCAL_PATH)/tee/custom_ta.ssw:system/lib/tee/custom_ta.ssw \
    $(LOCAL_PATH)/tee/libbassapp_ssw:system/lib/tee/libbassapp_ssw \
    $(LOCAL_PATH)/tee/smcl_ta_8500bx_secure.ssw:system/lib/tee/smcl_ta_8500bx_secure.ssw 

# Packages
PRODUCT_PACKAGES += \
    	GalaxyS2Settings 
    	
# NFC
PRODUCT_PACKAGES += \
	libnfc \
	libnfc_jni \
	Nfc \
	Tag

# Commands to migrate prefs from com.android.nfc3 to com.android.nfc
PRODUCT_COPY_FILES += \
	packages/apps/Nfc/migrate_nfc.txt:system/etc/updatecmds/migrate_nfc.txt

# file that declares the MIFARE NFC constant
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml

# NFC EXTRAS add-on API
PRODUCT_PACKAGES += \
	com.android.nfc_extras
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml

# NFCEE access control
ifeq ($(TARGET_BUILD_VARIANT),user)
	NFCEE_ACCESS_PATH := device/samsung/janicep/NFC/nfcee_access.xml
else
	NFCEE_ACCESS_PATH := device/samsung/janicep/NFC/nfcee_access_debug.xml
endif
PRODUCT_COPY_FILES += \
	$(NFCEE_ACCESS_PATH):system/etc/nfcee_access.xml

# RIL
PRODUCT_PROPERTY_OVERRIDES += \
    mobiledata.interfaces=pdp0,wlan0,gprs,ppp0 \
    ro.ril.hsxpa=1 \
    ro.ril.gprsclass=10 \
    ro.telephony.ril_class=SamsungU8500RIL \
    ro.telephony.sends_barcount=1

# Init files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/fstab.samsungjanicep:root/fstab.samsungjanicep \
    $(LOCAL_PATH)/rootdir/init.samsungjanicep.rc:root/init.samsungjanice.rcp \
    $(LOCAL_PATH)/rootdir/init.samsungjanicep.usb.rc:root/init.samsungjanicep.usb.rc \
    $(LOCAL_PATH)/rootdir/prerecovery.rc:root/prerecovery.rc \
    $(LOCAL_PATH)/rootdir/ueventd.samsungjanicep.rc:root/ueventd.samsungjanicep.rc

# RIL
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/configs/manuf_id.cfg:system/etc/AT/manuf_id.cfg \
   $(LOCAL_PATH)/configs/model_id.cfg:system/etc/AT/model_id.cfg \
   $(LOCAL_PATH)/configs/system_id.cfg:system/etc/AT/system_id.cfg

# Keylayout
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/usr/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    $(LOCAL_PATH)/usr/keylayout/janice-kp.kl:system/usr/keylayout/janice-kp.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_04e8_Product_7021.kl:system/usr/keylayout/Vendor_04e8_Product_7021.kl

# Use non-open-source parts if present
$(call inherit-product-if-exists, vendor/samsung/u8500-common/janicep/janice-vendor.mk)
