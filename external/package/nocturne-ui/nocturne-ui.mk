################################################################################
#
# nocturne-ui — Unchained fork (override-only, no remote fetch)
#
# Upstream: https://github.com/usenocturne/nocturne-ui
# Fork:     https://github.com/spencerthayer/nocturne-ui
#
# This package REQUIRES a local override.  Set NOCTURNE_UI_OVERRIDE_SRCDIR in
# output/local.mk pointing at a pre-built nocturne-ui checkout:
#
#   cd ../nocturne-ui && bun install && bun run build
#   echo 'NOCTURNE_UI_OVERRIDE_SRCDIR = $(TOPDIR)/../../../nocturne-ui' \
#       >> output/local.mk
#
# When OVERRIDE_SRCDIR is set Buildroot rsyncs locally and skips download.
# When it is NOT set, the build will fail loudly at extract time — there is
# no remote SITE to fall back to.
#
################################################################################

NOCTURNE_UI_VERSION = local
NOCTURNE_UI_SITE_METHOD = local
NOCTURNE_UI_SITE = /dev/null

define NOCTURNE_UI_EXTRACT_CMDS
	@if [ ! -d "$(@D)/dist" ] && [ ! -d "$(@D)/nocturne-ui" ]; then \
		echo ""; \
		echo "ERROR: NOCTURNE_UI_OVERRIDE_SRCDIR is not set."; \
		echo ""; \
		echo "nocturne-ui does not support remote download.  You must build the"; \
		echo "UI locally and point Buildroot at the checkout:"; \
		echo ""; \
		echo "  cd ../nocturne-ui && bun install && bun run build"; \
		echo "  echo 'NOCTURNE_UI_OVERRIDE_SRCDIR = \$$(TOPDIR)/../../../nocturne-ui' \\"; \
		echo "      >> output/local.mk"; \
		echo ""; \
		echo "See local.mk.example for details."; \
		echo ""; \
		exit 1; \
	fi
endef

define NOCTURNE_UI_INSTALL_TARGET_CMDS
	rm -rf $(TARGET_DIR)/etc/nocturne/ui
	mkdir -p $(TARGET_DIR)/etc/nocturne/ui
	if [ -d "$(@D)/dist" ]; then \
		cp -r $(@D)/dist/* $(TARGET_DIR)/etc/nocturne/ui/; \
	elif [ -d "$(@D)/nocturne-ui" ]; then \
		cp -r $(@D)/nocturne-ui/* $(TARGET_DIR)/etc/nocturne/ui/; \
	fi
endef

$(eval $(generic-package))
