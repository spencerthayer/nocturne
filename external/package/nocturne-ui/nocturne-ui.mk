################################################################################
#
# nocturne-ui — Unchained fork
#
# Upstream: https://github.com/usenocturne/nocturne-ui
# Fork:     https://github.com/spencerthayer/nocturne-ui
#
# The upstream .mk fetches a CI-produced zip from nightly.link.  The fork
# does not yet publish release zips, so this .mk is structured for two
# workflows:
#
#   1. LOCAL OVERRIDE (recommended during development)
#      Build the UI locally (bun install && bun run build), then set
#      NOCTURNE_UI_OVERRIDE_SRCDIR in output/local.mk pointing at the
#      nocturne-ui checkout.  Buildroot will rsync from there instead of
#      downloading anything.  See local.mk.example at the repo root.
#
#   2. FORK RELEASE ZIP (CI / final images)
#      Once the fork's GitHub Actions produce a dist zip on a release tag,
#      update NOCTURNE_UI_VERSION and NOCTURNE_UI_SITE below to point at
#      the fork's release asset URL.  Add NOCTURNE_UI_HASH if desired.
#
# WI5 (offline-integration) will finalize the fork CI workflow and pin a
# release tag here.
#
################################################################################

NOCTURNE_UI_VERSION = v4.0.7
NOCTURNE_UI_SOURCE = nocturne-ui.zip
NOCTURNE_UI_SITE = https://nightly.link/spencerthayer/nocturne-ui/workflows/build/$(NOCTURNE_UI_VERSION)
NOCTURNE_UI_METHOD = wget

define NOCTURNE_UI_EXTRACT_CMDS
	unzip $(NOCTURNE_UI_DL_DIR)/$(NOCTURNE_UI_SOURCE) -d $(@D)/nocturne-ui
endef

define NOCTURNE_UI_INSTALL_TARGET_CMDS
	rm -rf $(TARGET_DIR)/etc/nocturne/ui
	mkdir -p $(TARGET_DIR)/etc/nocturne/ui
	cp -r $(@D)/nocturne-ui/* $(TARGET_DIR)/etc/nocturne/ui/
endef

$(eval $(generic-package))
