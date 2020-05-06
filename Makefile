.PHONY: coverage

coverage:
	@dart --pause-isolates-on-exit --disable-service-auth-codes --enable-vm-service=9090 test/unit/kotlin_extensions_test.dart &

	@collect_coverage --wait-paused --uri=http://127.0.0.1:9090/ -o coverage/coverage.json --resume-isolates && \
		format_coverage -l -i coverage/coverage.json -o coverage/lcov.info --packages=.packages --report-on=lib && \
		genhtml coverage/lcov.info --output-directory coverage/out

see-coverage: coverage
	open coverage/out/index.html
