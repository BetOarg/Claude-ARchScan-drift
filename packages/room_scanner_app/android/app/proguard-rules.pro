# ARchScan release shrinker rules.
#
# Flutter, AndroidX and native plugins publish their own consumer rules.
# Add a rule here only when a release-runtime test shows an R8 regression.

# Drift uses dart:ffi to load native libsqlite3.so — no Java classes to keep.

# AR Flutter Plugin uses platform views with reflection.
-keep class io.carius.** { *; }
