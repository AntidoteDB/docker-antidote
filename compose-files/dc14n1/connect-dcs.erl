#!/usr/bin/env escript
%%! -smp enable -sname erlshell -setcookie secret -hidden
main(_Args) ->
    timer:sleep(15000),

    Nodes = [
             antidote@dc1n1,
             antidote@dc2n1,
             antidote@dc3n1,
             antidote@dc4n1,
             antidote@dc5n1,
             antidote@dc6n1,
             antidote@dc7n1,
             antidote@dc8n1,
             antidote@dc9n1,
             antidote@dc10n1,
             antidote@dc11n1,
             antidote@dc12n1,
             antidote@dc13n1,
             antidote@dc14n1
            ],

    Descriptors = [ getDesc(Node) || Node <- Nodes ],

    lists:foreach(fun(Node) -> 
        Response = rpc:call(Node, antidote_dc_manager, subscribe_updates_from, [Descriptors], 35000),
        io:format("~n===============~nResponse from DC: ~p ~n===========~n", [Response])
                  end, 
                  Nodes).


getDesc(Node) ->
    E = (catch rpc:call(Node, antidote_dc_manager, get_connection_descriptor, [])),
    case E of
        {ok, Desc} -> Desc;
        {badrpc, {_, {{badmatch, {error, node_still_starting}}, _}}} -> getDesc(Node);
        _ -> io:format("~n============~nError ~p~n===========~n", [E])
    end.

