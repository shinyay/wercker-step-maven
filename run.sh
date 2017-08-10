#!/bin/sh

### Check if Maven is installed
if ! type mvn >/dev/null 2>&1; then
  error "Maven is not installed"
else
  info "Maven is installed"
  info "$(type mvn)"
  debug "$(mvn -version)"
fi

### Check if Maven Goal is configured
if [[ -z $WERCKER_MAVEN_GOALS ]]; then
  error "Maven Goal is not configured"
fi

run() {
  mvn \
    --update-snapshots \
    --batch-mode \
    -Dmaven.repo.local=${WERCKER_CACHE_DIR} \
    ${WERCKER_MAVEN_GOALS}
}

run
