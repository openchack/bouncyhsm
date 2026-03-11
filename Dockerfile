FROM alpine:3.23

ENV APP_VERSION=2.0.1

WORKDIR /unzip
ADD https://github.com/harrison314/BouncyHsm/releases/download/v2.0.1/BouncyHsm.zip .
RUN apk --update add unzip && rm -rf /var/cache/apk/* && unzip BouncyHsm.zip && rm BouncyHsm.zip

FROM debian
WORKDIR /App

COPY --from=0 /unzip/native/Linux-x64 /App/NativeLibLocation

CMD ["example_application", "-p11libPath", "/App/NativeLibLocation/BouncyHsm.Pkcs11Lib.so"]
