cc_binary(
    name = "main",
    srcs = ["src/main.cpp"],
    copts = [
        "-std=c++14",
        "-Wall",
        "-Wextra",
        "-fstack-protector",
        "-fno-omit-frame-pointer",
    ],
    target_compatible_with = select({
        "@platforms//os:linux": [],
        "@platforms//os:windows": [],
        "@platforms//os:macos": [],
        "//conditions:default": [],
    }),
)
