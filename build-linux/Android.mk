#
# Copyright (C) YuqiaoZhang(HanetakaChou)
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
# 
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

# https://developer.android.com/ndk/guides/android_mk

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := flatbuffers

LOCAL_SRC_FILES := \
	$(LOCAL_PATH)/../src/idl_gen_text.cpp \
	$(LOCAL_PATH)/../src/idl_parser.cpp \
	$(LOCAL_PATH)/../src/reflection.cpp \
	$(LOCAL_PATH)/../src/util.cpp

LOCAL_CFLAGS :=

ifeq (armeabi-v7a,$(TARGET_ARCH_ABI))
LOCAL_ARM_MODE := arm
LOCAL_ARM_NEON := true
else ifeq (arm64-v8a,$(TARGET_ARCH_ABI))
LOCAL_CFLAGS +=
else ifeq (x86,$(TARGET_ARCH_ABI))
LOCAL_CFLAGS += -mf16c
LOCAL_CFLAGS += -mfma
LOCAL_CFLAGS += -mavx2
else ifeq (x86_64,$(TARGET_ARCH_ABI))
LOCAL_CFLAGS += -mf16c
LOCAL_CFLAGS += -mfma
LOCAL_CFLAGS += -mavx2
else
LOCAL_CFLAGS +=
endif

LOCAL_CFLAGS += -Wall
LOCAL_CFLAGS += -Werror=return-type

LOCAL_CFLAGS += -DFLATBUFFERS_LOCALE_INDEPENDENT=1

LOCAL_C_INCLUDES :=
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../include

LOCAL_CPPFLAGS := 
LOCAL_CPPFLAGS += -std=c++17

include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE := flatc

LOCAL_SRC_FILES := \
	$(LOCAL_PATH)/../grpc/src/compiler/cpp_generator.cc \
	$(LOCAL_PATH)/../grpc/src/compiler/go_generator.cc \
	$(LOCAL_PATH)/../grpc/src/compiler/java_generator.cc \
	$(LOCAL_PATH)/../grpc/src/compiler/python_generator.cc \
	$(LOCAL_PATH)/../grpc/src/compiler/swift_generator.cc \
	$(LOCAL_PATH)/../grpc/src/compiler/ts_generator.cc \
	$(LOCAL_PATH)/../src/annotated_binary_text_gen.cpp \
	$(LOCAL_PATH)/../src/bfbs_gen_lua.cpp \
	$(LOCAL_PATH)/../src/bfbs_gen_nim.cpp \
	$(LOCAL_PATH)/../src/binary_annotator.cpp \
	$(LOCAL_PATH)/../src/code_generators.cpp \
	$(LOCAL_PATH)/../src/file_binary_writer.cpp \
	$(LOCAL_PATH)/../src/file_name_saving_file_manager.cpp \
	$(LOCAL_PATH)/../src/file_writer.cpp \
	$(LOCAL_PATH)/../src/flatc.cpp \
	$(LOCAL_PATH)/../src/flatc_main.cpp \
	$(LOCAL_PATH)/../src/idl_gen_binary.cpp \
	$(LOCAL_PATH)/../src/idl_gen_cpp.cpp \
	$(LOCAL_PATH)/../src/idl_gen_csharp.cpp \
	$(LOCAL_PATH)/../src/idl_gen_dart.cpp \
	$(LOCAL_PATH)/../src/idl_gen_fbs.cpp \
	$(LOCAL_PATH)/../src/idl_gen_go.cpp \
	$(LOCAL_PATH)/../src/idl_gen_grpc.cpp \
	$(LOCAL_PATH)/../src/idl_gen_java.cpp \
	$(LOCAL_PATH)/../src/idl_gen_json_schema.cpp \
	$(LOCAL_PATH)/../src/idl_gen_kotlin.cpp \
	$(LOCAL_PATH)/../src/idl_gen_kotlin_kmp.cpp \
	$(LOCAL_PATH)/../src/idl_gen_lobster.cpp \
	$(LOCAL_PATH)/../src/idl_gen_php.cpp \
	$(LOCAL_PATH)/../src/idl_gen_python.cpp \
	$(LOCAL_PATH)/../src/idl_gen_rust.cpp \
	$(LOCAL_PATH)/../src/idl_gen_swift.cpp \
	$(LOCAL_PATH)/../src/idl_gen_ts.cpp

LOCAL_CFLAGS :=

ifeq (armeabi-v7a,$(TARGET_ARCH_ABI))
LOCAL_ARM_MODE := arm
LOCAL_ARM_NEON := true
else ifeq (arm64-v8a,$(TARGET_ARCH_ABI))
LOCAL_CFLAGS +=
else ifeq (x86,$(TARGET_ARCH_ABI))
LOCAL_CFLAGS += -mavx2
else ifeq (x86_64,$(TARGET_ARCH_ABI))
LOCAL_CFLAGS += -mavx2
else
LOCAL_CFLAGS +=
endif

LOCAL_CFLAGS += -Wall
LOCAL_CFLAGS += -Werror=return-type

LOCAL_CFLAGS += -DFLATBUFFERS_LOCALE_INDEPENDENT=1

LOCAL_C_INCLUDES :=
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../include
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../grpc

LOCAL_CPPFLAGS := 
LOCAL_CPPFLAGS += -std=c++17

LOCAL_LDFLAGS :=
LOCAL_LDFLAGS += -Wl,--enable-new-dtags
LOCAL_LDFLAGS += -Wl,-rpath,\$$ORIGIN
LOCAL_LDFLAGS += -Wl,--version-script,$(LOCAL_PATH)/flatc.map

LOCAL_STATIC_LIBRARIES :=
LOCAL_STATIC_LIBRARIES += flatbuffers

include $(BUILD_EXECUTABLE)
