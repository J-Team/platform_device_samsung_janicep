# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)
# ^^ If it doesn't work, use this --> $(call inherit-product, $(SRC_TARGET_DIR)/product/tiny_aosp.mk) ^^
$(call inherit-product, device/samsung/janicep/full_janicep.mk)

# Discard inherited values and use our own instead.
PRODUCT_NAME := full_janicep
PRODUCT_DEVICE := janicep
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_MODEL := GT-I9070P
