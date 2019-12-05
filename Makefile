PHONY: requires clean deb
CURRENT_DIR=$(shell pwd)

requires:
	cd debian; \
	ln -fs control.$(VERSION) control; \
	ln -fs changelog.$(VERSION) changelog; \

clean:
	rm debian/control
	rm debian/changelog

deb: requires
	dpkg-buildpackage 							\
		-B 														\
		--no-sign  										\
		-jauto 												\
		--compression=xz 							\
		--compression-level=9 				\
		--buildinfo-option="-u$(CURRENT_DIR)" 	\
		--changes-option="-u$(CURRENT_DIR)" 		\
