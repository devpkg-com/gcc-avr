CURRENT_DIR = $(shell pwd)
TARBALL_NAME = gcc-$(VERSION).tar.xz
SOURCE_URL = https://mirrors.kernel.org/gnu/gcc/gcc-$(VERSION)/$(TARBALL_NAME)
SOURCE_DIR = $(CURRENT_DIR)/src


$(TARBALL_NAME):
	wget -q -N $(SOURCE_URL)

$(SOURCE_DIR): $(TARBALL_NAME)
	mkdir -p $(SOURCE_DIR)
	tar --strip-components=1 -xf $(TARBALL_NAME) -C $(SOURCE_DIR)

requires:
	echo $(CURRENT_DIR); \
	$(CURRENT_DIR)/deb_files.py $(VERSION) $(DISTRO_NAME) > debian/changelog; \

clean:
	rm debian/changelog

deb: requires $(SOURCE_DIR)
	SOURCE_DIR=$(SOURCE_DIR) dpkg-buildpackage 							\
		-B 														\
		--no-sign  										\
		-jauto 												\
		--compression=xz 							\
		--compression-level=9 				\
		--buildinfo-option="-u$(CURRENT_DIR)" 	\
		--changes-option="-u$(CURRENT_DIR)" 		\

artifacts:
	mkdir -p artifacts
	mv *.deb artifacts

PHONY: requires clean deb
