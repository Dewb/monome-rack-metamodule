echo Running Teletype code generation with Ragel...

ragel -C -G2 src/match_token.rl -o src/match_token.c
ragel -C -G2 src/scanner.rl -o src/scanner.c

echo "const char *git_version = \"5.0 $(git describe --always --dirty --exclude '*' | tr '[a-z]' '[A-Z]')\";" > module/gitversion.c