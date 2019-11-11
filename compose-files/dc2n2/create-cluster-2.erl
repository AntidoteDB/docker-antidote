#!/usr/bin/env escript
%%! -smp enable -sname erlshell -setcookie secret
main(Args) ->
    % hack until #396 is fixed
    % if node is still starting, retry
    % if another error happens (already a dc), stop
    E = (catch rpc:call(antidote@dc2n1, antidote_dc_manager, create_dc, [[antidote@dc2n1, antidote@dc2n2]])),
    case E of
        ok -> io:format("Data centers connected!~n");
        {badrpc, {_, {{badmatch, {error, node_still_starting}}, _}}} -> main(Args);
        _ -> io:format("Error ~p~n", [E])
    end.


