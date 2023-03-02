<<<<<<< HEAD:test/log4shell/Dockerfile
FROM trailofbits/openjdk-i386 as openjdk

FROM rust:1.57

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y nasm gdb gcc-multilib

RUN mkdir /jdk

=======
FROM trailofbits/sholva AS sholva
FROM trailofbits/openjdk-i386 AS jdk

# sholva artifacts
RUN mkdir /nix/
COPY --from=trailofbits/sholva /nix /nix
COPY --from=trailofbits/sholva /bin /bin

# JDK artifacts
ENV PATH=/jdk/build/linux-x86-server-release/jdk/bin:$PATH
ENV LD_LIBRARY_PATH=/jdk/build/linux-x86-server-release/jdk/lib:LD_LIBRARY_PATH
>>>>>>> 1252281 (TASK(jl): fully integrated Docker+nix):exploit/log4shell/Dockerfile
COPY --from=trailofbits/openjdk-i386 /jdk /jdk

ENV PATH=/jdk/build/linux-x86-server-release/jdk/bin:/app/mttn/target/debug/:$PATH
ENV LD_LIBRARY_PATH=/jdk/build/linux-x86-server-release/jdk/lib:LD_LIBRARY_PATH

WORKDIR /app/mttn

CMD /bin/sh
