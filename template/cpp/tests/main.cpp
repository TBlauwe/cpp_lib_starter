#define DOCTEST_CONFIG_IMPLEMENT
#include <doctest/doctest.h>

int main(int argc, char** argv) {
    doctest::Context context;

    context.applyCommandLine(argc, argv);

    // overrides - See https://github.com/doctest/doctest/blob/master/doc/markdown/commandline.md
    context.setOption("no-path-filenames", true);   // Don't show path
    context.setOption("no-breaks", true);           // don't break in the debugger when assertions fail

    return context.run(); 
}
