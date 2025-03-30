.PHONY: build
build:
ifeq ($(MAKE_USE_DOCKER),)
	latexmk -f
else
	docker build -o . .
endif

.PHONY: clean
clean:
	latexmk -C
