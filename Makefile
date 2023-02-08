CHART_NAME=mailslurper
CHART_PATH=chart/$(CHART_NAME)
LATEST_TAG?="0.1.0"

.PHONY: test testdeps

helm-package: helm-version
	helm package $(CHART_PATH)

helm-version:
	sed -i "s/^version:.*/version: $(VERSION)/g" $(CHART_PATH)/Chart.yaml
	sed -i "s/^appVersion:.*/appVersion: $(VERSION)/g" $(CHART_PATH)/Chart.yaml

helm-lint:
	helm lint $(CHART_PATH)

helm-publish: helm-package
	curl -T $(CHART_NAME)-$(VERSION).tgz "https://$(ARTIFACTORY_USERNAME):$(ARTIFACTORY_TOKEN)@metaplay.jfrog.io/artifactory/helm-stable/$(CHART_NAME)-$(VERSION).tgz"
	
testdeps:
	echo "no tests to run"

test: testdeps
	echo "no test deps to install"

lint: testdeps
	echo "nothing to lint"
