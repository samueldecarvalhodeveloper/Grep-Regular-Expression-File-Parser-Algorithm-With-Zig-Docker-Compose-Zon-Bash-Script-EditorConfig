#syntax=docker/dockerfile:1

FROM ziglings/ziglang:0.12.0

WORKDIR /src/app/

COPY ./build.zig.zon /src/app/build.zig.zon
COPY ./build.zig /src/app/build.zig
COPY ./src/ /src/app/src/
COPY ./res/ /src/app/res/

RUN zig build

CMD ./zig-out/bin/regular_expression Lorem /src/app/res/lorem_ipsum.txt
