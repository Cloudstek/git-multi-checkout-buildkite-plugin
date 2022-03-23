#!/usr/bin/env bats

load '/usr/local/lib/bats/load.bash'

# Uncomment the following line to debug stub failures
 export BUILDKITE_AGENT_STUB_DEBUG=/dev/tty

export BUILDKITE_BUILD_CHECKOUT_PATH="/workspace"

@test "Clone single repository" {
    export BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_0="git@github.com:/foo/foo.git"

    stub git \
        "clone git@github.com:/foo/foo.git foo : echo cloned repository git@github.com:/foo/foo.git"

    run $PWD/hooks/post-checkout

    assert_success
    assert_output --partial "cloned repository git@github.com:/foo/foo.git"

    unstub git
    unset BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_0
    rm -Rf "${BUILDKITE_BUILD_CHECKOUT_PATH}"/*
}

@test "Clone single repository with clone flags" {
    export BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_CLONE_FLAGS="--depth 1 -v"
    export BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_0="git@github.com:/foo/foo.git"

    stub git \
        "clone --depth 1 -v git@github.com:/foo/foo.git foo : echo cloned repository git@github.com:/foo/foo.git"

    run $PWD/hooks/post-checkout

    assert_success
    assert_output --partial "cloned repository git@github.com:/foo/foo.git"

    unstub git
    unset BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_CLONE_FLAGS
    unset BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_0
    rm -Rf "${BUILDKITE_BUILD_CHECKOUT_PATH}"/*
}

@test "Clone multiple repositories" {
    export BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_0="git@github.com:/foo/foo.git"
    export BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_1="git@github.com:/foo/bar.git"

    stub git \
        "clone git@github.com:/foo/foo.git foo : echo cloned repository git@github.com:/foo/foo.git" \
        "clone git@github.com:/foo/bar.git bar : echo cloned repository git@github.com:/foo/bar.git"

    run $PWD/hooks/post-checkout

    assert_success
    assert_output --partial "cloned repository git@github.com:/foo/foo.git"
    assert_output --partial "cloned repository git@github.com:/foo/bar.git"

    unstub git
    unset BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_0
    unset BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_1
    rm -Rf "${BUILDKITE_BUILD_CHECKOUT_PATH}"/*
}

@test "Clone multiple repositories with clone flags" {
    export BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_CLONE_FLAGS="--depth 1 -v"
    export BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_0="git@github.com:/foo/foo.git"
    export BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_1="git@github.com:/foo/bar.git"

    stub git \
        "clone --depth 1 -v git@github.com:/foo/foo.git foo : echo cloned repository git@github.com:/foo/foo.git" \
        "clone --depth 1 -v git@github.com:/foo/bar.git bar : echo cloned repository git@github.com:/foo/bar.git"

    run $PWD/hooks/post-checkout

    assert_success
    assert_output --partial "cloned repository git@github.com:/foo/foo.git"
    assert_output --partial "cloned repository git@github.com:/foo/bar.git"

    unstub git
    unset BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_CLONE_FLAGS
    unset BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_0
    unset BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_1
    rm -Rf "${BUILDKITE_BUILD_CHECKOUT_PATH}"/*
}

@test "Pull single repository" {
    export BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_0="git@github.com:/foo/foo.git"

    stub git \
        "pull --force : echo pulled repository git@github.com:/foo/foo.git"

    mkdir "${BUILDKITE_BUILD_CHECKOUT_PATH}/foo"
    run $PWD/hooks/post-checkout

    assert_success
    assert_output --partial "pulled repository git@github.com:/foo/foo.git"

    unstub git
    unset BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_0
    rm -Rf "${BUILDKITE_BUILD_CHECKOUT_PATH}"/*
}

@test "Pull single repository with pull flags" {
    export BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_PULL_FLAGS="-v --prune"
    export BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_0="git@github.com:/foo/foo.git"

    stub git \
        "pull --force -v --prune : echo pulled repository git@github.com:/foo/foo.git"

    mkdir "${BUILDKITE_BUILD_CHECKOUT_PATH}/foo"
    run $PWD/hooks/post-checkout

    assert_success
    assert_output --partial "pulled repository git@github.com:/foo/foo.git"

    unstub git
    unset BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_PULL_FLAGS
    unset BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_0
    rm -Rf "${BUILDKITE_BUILD_CHECKOUT_PATH}"/*
}

@test "Pull multiple repositories" {
    export BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_0="git@github.com:/foo/foo.git"
    export BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_1="git@github.com:/foo/bar.git"

    stub git \
        "pull --force : echo pulled repository git@github.com:/foo/foo.git" \
        "pull --force : echo pulled repository git@github.com:/foo/bar.git"

    mkdir "${BUILDKITE_BUILD_CHECKOUT_PATH}/foo"
    mkdir "${BUILDKITE_BUILD_CHECKOUT_PATH}/bar"
    run $PWD/hooks/post-checkout

    assert_success
    assert_output --partial "pulled repository git@github.com:/foo/foo.git"
    assert_output --partial "pulled repository git@github.com:/foo/bar.git"

    unstub git
    unset BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_0
    unset BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_1
    rm -Rf "${BUILDKITE_BUILD_CHECKOUT_PATH}"/*
}

@test "Pull multiple repositories with pull flags" {
    export BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_PULL_FLAGS="-v --prune"
    export BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_0="git@github.com:/foo/foo.git"
    export BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_1="git@github.com:/foo/bar.git"

    stub git \
        "pull --force -v --prune : echo pulled repository git@github.com:/foo/foo.git" \
        "pull --force -v --prune : echo pulled repository git@github.com:/foo/bar.git"

    mkdir "${BUILDKITE_BUILD_CHECKOUT_PATH}/foo"
    mkdir "${BUILDKITE_BUILD_CHECKOUT_PATH}/bar"
    run $PWD/hooks/post-checkout

    assert_success
    unset BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_PULL_FLAGS
    assert_output --partial "pulled repository git@github.com:/foo/foo.git"
    assert_output --partial "pulled repository git@github.com:/foo/bar.git"

    unstub git
    unset BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_0
    unset BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_1
    rm -Rf "${BUILDKITE_BUILD_CHECKOUT_PATH}"/*
}

@test "Clone and pull multiple repositories" {
    export BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_0="git@github.com:/foo/foo.git"
    export BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_1="git@github.com:/foo/bar.git"

    stub git \
        "clone git@github.com:/foo/foo.git foo : echo cloned repository git@github.com:/foo/foo.git" \
        "pull --force : echo pulled repository git@github.com:/foo/bar.git"

    mkdir "${BUILDKITE_BUILD_CHECKOUT_PATH}/bar"
    run $PWD/hooks/post-checkout

    assert_output --partial "cloned repository git@github.com:/foo/foo.git"
    assert_output --partial "pulled repository git@github.com:/foo/bar.git"

    unstub git
    unset BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_0
    unset BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_1
    rm -Rf "${BUILDKITE_BUILD_CHECKOUT_PATH}"/*
}

@test "Clone and pull multiple repositories with flags" {
    rm -Rf "${BUILDKITE_BUILD_CHECKOUT_PATH}"/*
    export BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_PULL_FLAGS="-v --prune"
    export BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_CLONE_FLAGS="--depth 1 -v"
    export BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_0="git@github.com:/foo/foo.git"
    export BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_1="git@github.com:/foo/bar.git"

    stub git \
        "clone --depth 1 -v git@github.com:/foo/foo.git foo : echo cloned repository git@github.com:/foo/foo.git" \
        "pull --force -v --prune : echo pulled repository git@github.com:/foo/bar.git"

    mkdir "${BUILDKITE_BUILD_CHECKOUT_PATH}/bar"
    run $PWD/hooks/post-checkout

    assert_output --partial "cloned repository git@github.com:/foo/foo.git"
    assert_output --partial "pulled repository git@github.com:/foo/bar.git"

    unstub git
    unset BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_PULL_FLAGS
    unset BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_CLONE_FLAGS
    unset BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_0
    unset BUILDKITE_PLUGIN_GIT_MULTI_CHECKOUT_REPOSITORIES_1
}
