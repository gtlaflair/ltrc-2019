if (!dir.exists("data"))
    dir.create("data")

if (! file.exists("data/placement_1.csv")) {
download.file("https://raw.githubusercontent.com/gtlaflair/ltrc-2019/gh-pages/data/placement_1.csv",
              "data/placement_1.csv", mode = "wb")
}

if (! file.exists("data/placement_1.csv")) {
download.file("https://raw.githubusercontent.com/gtlaflair/ltrc-2019/gh-pages/data/placement_2.csv",
              "data/placement_2.csv", mode = "wb")
}

if (! file.exists("data/placement_1.csv")) {
download.file("https://raw.githubusercontent.com/gtlaflair/ltrc-2019/gh-pages/data/integrated.csv",
              "data/integrated.csv", mode = "wb")
}
