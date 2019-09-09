-module(server).

-export([start/1, stop/0, bench/0]).

start(Port) ->
    register(rudy, spawn(fun () -> rudy:init(Port) end)).

stop() -> exit(whereis(rudy), "time to die").

bench() ->
    Start = erlang:system_time(micro_seconds), %Start measure execution time
    test:run(localhost, 8080, 100), %call run method 
    Finish = erlang:system_time(micro_seconds), %stop measuring time
    ExTime = Finish - Start, %calculate execution time
    io:format("The requests took ~w μs to finish ~n", [ExTime]).
