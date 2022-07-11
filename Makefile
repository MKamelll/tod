SRC=./examples

test: $(SRC)/*.d
	mkdir -p test
	dmd $^ -of=test/$@
	./test/test