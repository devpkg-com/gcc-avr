PHONY: requires


requires:
	cd debian; \
	ln -s control.${VERSION} control; \
	ln -s changelog.${VERSION} changelog; \

clean:
	rm debian/control
	rm debian/changelog
