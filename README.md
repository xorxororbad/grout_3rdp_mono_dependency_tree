* Steps for adding new mirrors:
1. Clone the repository as a mirror.
@code bash
    git clone --mirror https://github.com/wolfpld/tracy.git tracy
@end

2. Create a new empty mirror repository on the server (github) through the web interface.

3. Push the local mirror project to the github mirror.
@code bash
    cd ./mirrors/tracy
    git push --mirror git@github.com:xorxororbad/mirror-tracy.git
@end

4. Remove contents of the mirrored repo.
@code bash
    cd ./mirrors/
    rm -rf ./tracy
@end

5. Add the mirror repository as a submodule.
@code bash
    cd ./mirrors/
    git submodule add git@github.com:xorxororbad/mirror-tracy.git tracy
@end

6. Edit `.envrc.pub` and add direnv step that adds git `upstream` remote.
@code bash
    pushd "${PRV_PROJECT_ROOT}/mirrors/tracy"
        git remote add upstream https://github.com/wolfpld/tracy.git > /dev/null 2>&1;
    popd
@end

7. Remove the sentinel file `.init.sentinel` to run the initialization again.

