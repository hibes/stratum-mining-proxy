FROM alpine:3.4

WORKDIR /app
EXPOSE 3333
EXPOSE 8332

RUN apk update && \
	apk add --no-cache \
	build-base \
	ca-certificates \
	git \
	libffi-dev \
	openssl-dev \
	python-dev \
	py-pip && \
	update-ca-certificates

RUN pip install --upgrade pip && \
	pip install --upgrade setuptools && \
	pip install --upgrade distribute

RUN git clone https://github.com/hibes/stratum.git && \
	cd stratum && \
	python setup.py develop

COPY . ./

RUN python setup.py develop

ENTRYPOINT ["./mining_proxy.py"]
