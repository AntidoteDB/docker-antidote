#!/usr/bin/env escript
%%! -smp enable -sname erlshell -setcookie secret -hidden

main(_Args) ->
    timer:sleep(15000),

    {ok, Desc1} = getDesc(antidote@dc1n1),
    io:format("~n===============~nDescriptor DC1: ~p ~n===========~n", [Desc1]),

    {ok, Desc2} = getDesc(antidote@dc2n1),
    io:format("~n===============~nDescriptor DC2: ~p ~n===========~n", [Desc2]),

    Response = rpc:call('antidote@dc1n1', antidote_dc_manager, subscribe_updates_from, [[Desc2]], 25000),
    io:format("~n===============~nResponse from DC1: ~p ~n===========~n", [Response]),

    Response2 = rpc:call('antidote@dc2n1', antidote_dc_manager, subscribe_updates_from, [[Desc1]], 25000),
    io:format("~n===============~nResponse from DC2: ~p ~n===========~n", [Response2]).



getDesc(Node) ->
    E = (catch rpc:call(Node, antidote_dc_manager, get_connection_descriptor, [])),
    case E of
        {ok, Desc} -> {ok, Desc};
        {badrpc, {_, {{badmatch, {error, node_still_starting}}, _}}} -> getDesc(Node);
        _ -> io:format("~n============~nError ~p~n===========~n", [E])
    end.

