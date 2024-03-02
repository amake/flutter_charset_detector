do_all_projects = for p in flutter_charset_detector*; do (cd $$p && $(1)); done
jschardet_version := v3.0.0
jschardet_url := https://raw.githubusercontent.com/aadsm/jschardet/$(jschardet_version)/dist/jschardet.min.js
jschardet := flutter_charset_detector_web/lib/assets/web/jschardet.min.js

.PHONY: deps
deps: ## Fetch deps in all subprojects
	$(call do_all_projects,flutter pub get $(args))

.PHONY: outdated
outdated: ## Check outdated deps in all subprojects
	$(call do_all_projects,flutter pub outdated $(args))

.PHONY: upgrade
upgrade: ## Upgrade deps in all subprojects
	$(call do_all_projects,flutter pub upgrade $(args))

.PHONY: analyze
analyze: ## Run analysis in all subprojects
	flutter analyze flutter_charset_detector*

.PHONY: test
test: ## Run tests in all subprojects
	for t in flutter_charset_detector*/test flutter_charset_detector*/*/test; do (cd $$t/.. && flutter test); done

.PHONY: assets
assets: ## Download vendor assets
assets: $(jschardet)

$(jschardet):
	mkdir -p $(@D)
	curl -o $(@) $(jschardet_url)

.PHONY: clobber
clobber: ## Delete all vendor files
clobber:
	rm -rf $(jschardet)

.PHONY: help
help: ## Show this help text
	$(info usage: make [target])
	$(info )
	$(info Available targets:)
	@awk -F ':.*?## *' '/^[^\t].+?:.*?##/ \
         {printf "  %-24s %s\n", $$1, $$2}' $(MAKEFILE_LIST)
