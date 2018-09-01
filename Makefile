.PHONY: test

install:
	mix deps.get

console:
	iex -S mix

docs:
	mix docs

publish:
	mix hex.publish

test:
	iex -S mix test --trace
