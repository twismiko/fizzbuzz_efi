#
#Ref:http://orumin.blogspot.jp/2014/12/uefi.html
#
ARCH		= x86_64
EFIROOT 	= /usr
HDDRROOT	= $(EFIROOT)/include/efi
INCLUDES	= -I. -I$(HDDRROOT) -I$(HDDRROOT)/$(ARCH)	-I$(HDDRROOT)/protocol

CRTOBJS		= $(EFIROOT)/lib/crt0-efi-$(ARCH).o
CFLAGS		= -O2 -fPIC -Wall -fshort-wchar -fno-strict-aliasing -fno-merge-constants -mno-red-zone
ifeq ($(ARCH),x86_64)
		CFLAGS += -DEFI_FUNCTION_WRAPPER
	endif

CPPFLAGS	= -DCONFIG_$(ARCH)
FORMAT		= efi-app-$(ARCH)
INSTALL		= install
LDFLAGS		= -nostdlib
LDSCRIPT	= $(EFIROOT)/lib/elf_$(ARCH)_efi.lds
LDFLAGS	   += -T $(LDSCRIPT) -shared -Bsymbolic -L$(EFIROOT)/lib $(CRTOBJS)
LOADLIBS	= -lefi -lgnuefi $(shell $(CC) -print-libgcc-file-name)

prefix		=
CC			= $(prefix)gcc
AS			= $(prefix)as
LD			= $(prefix)ld
AR			= $(prefix)ar
RANLIB		= $(prefix)ranlib
OBJCOPY		= $(prefix)objcopy

%.efi: %.so
		$(OBJCOPY) -j .text -j .sdata -j .data -j .dynamic -j .dynsym -j .rel \
						   -j .rela -j .reloc --target=$(FORMAT) $*.so $@

%.so: %.o
		$(LD) $(LDFLAGS) $^ -o $@ $(LOADLIBS)

%.o: %.c
		$(CC) $(INCLUDES) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

TARGETS = hello.efi

all: $(TARGETS)

clean:
		rm -f $(TARGETS)
