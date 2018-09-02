.PHONY: test

install:
	mix deps.get

console:
	iex -S mix

docs:
	mix docs

publish:
	git commit -v -m "Release $(VERSION)" && \
	git push && \
	git tag $(VERSION) && \
	git push --tags && \
	mix hex.publish

test:
	iex -S mix test --trace
