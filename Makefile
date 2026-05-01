base:
		./pkgs/base.sh

desktop:
		./pkgs/desktop.sh

dev-base:
		./pkgs/dev-base.sh
dev-jvm:
		./pkgs/dev-jvm.sh

notebook:
		./pkgs/notebook.sh

notebook-x1g10:
		./pkgs/notebook-x1g10.sh

# Run a single unit's config script (no package install)
# Usage: make unit U=bash
unit:
	@[ -n "$(U)" ] || (echo "Usage: make unit U=<unit-name>"; exit 1)
	./units/$(U)/unit.sh

# Show state files (resume points) and recent logs
status:
	@echo "--- state files (completed packages per profile) ---"
	@ls .env-state-* 2>/dev/null | while read f; do \
		echo "$$f:"; sed 's/^/  /' "$$f"; \
	done || echo "  none"
	@echo ""
	@echo "--- recent logs ---"
	@ls -t /tmp/env-*.log 2>/dev/null | head -5 || echo "  none"

# Remove state files so next run starts fresh
clean-state:
	rm -f .env-state-*
	@echo "State cleared."
