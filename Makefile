# all: deps, compile

deps:
	test -d deps || rebar get-deps

compile:
	rebar compile
ws:
	@erl -noshell -pa './ebin' -s simple_web_server start

dev:
	@erl -boot start_clean -pa './ebin'

# add boot config suitable for production
pd:
	@erl -boot start_sasl -config local -pa './ebin'


dist:
	# erl -name ... -setcookie ... \
		-kernel inet_dist_listen_min Min inet_dist_listen_max Max
