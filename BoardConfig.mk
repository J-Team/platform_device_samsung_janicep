# Inherit from the proprietary version
-include vendor/samsung/u8500-common/BoardConfigVendor.mk

# Include device -- > u8500-common
-include device/samsung/u8500-common/BoardCommonConfig.mk

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/samsung/janicep/bluetooth

# Vibrator
BOARD_HAS_VIBRATOR_IMPLEMENTATION := ../../device/samsung/janice/vibrator/vibrator.c

# Recovery
TARGET_RECOVERY_FSTAB := device/samsung/janice/rootdir/fstab.samsungjanice

# Kernel
TARGET_KERNEL_SOURCE := kernel/samsung/u8500
TARGET_KERNEL_CONFIG := cyanogenmod_i9070p_defconfig
TARGET_KERNEL_CUSTOM_TOOLCHAIN := arm-eabi-4.6

# Assert
TARGET_OTA_ASSERT_DEVICE := janicep,i9070P,GT-I9070P
