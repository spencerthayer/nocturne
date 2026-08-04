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
# When it is NOT set, the build fails at parse time — there is no remote SITE.
#
################################################################################

ifeq ($(NOCTURNE_UI_OVERRIDE_SRCDIR),)
$(error NOCTURNE_UI_OVERRIDE_SRCDIR is unset. Build nocturne-ui locally and set it in output/local.mk — see local.mk.example)
endif

NOCTURNE_UI_VERSION = local

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
