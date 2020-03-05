.PHONY: all
all:

.PHONY: test
test: checkstyle unit

.PHONY: unit
unit:
	cat ./tests/incompletes | env dry_run=1 bash -ex ./openqa-label-known-issues

.PHONY: checkstyle
checkstyle: test-shellcheck test-yaml

.PHONY: test-shellcheck
test-shellcheck:
	@which shellcheck >/dev/null 2>&1 || echo "Command 'shellcheck' not found, can not execute shell script checks"
	shellcheck -x $$(file --mime-type * | sed -n 's/^\(.*\):.*text\/x-shellscript.*$$/\1/p')

.PHONY: test-yaml
test-yaml:
	@which yamllint >/dev/null 2>&1 || echo "Command 'yamllint' not found, can not execute YAML syntax checks"
	yamllint --strict $$(git ls-files "*.yml" "*.yaml")
