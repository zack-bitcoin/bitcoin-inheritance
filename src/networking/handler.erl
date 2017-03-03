-module(handler).

-export([init/3, handle/2, terminate/3, doit/1]).
%example of talking to this handler:
%httpc:request(post, {"http://127.0.0.1:3010/", [], "application/octet-stream", "echo"}, [], []).
%curl -i -d '[-6,"test"]' http://localhost:3011
%curl -i -d echotxt http://localhost:3010

handle(Req, State) ->
    %{Length, Req2} = cowboy_req:body_length(Req),
    {ok, Data, Req3} = cowboy_req:body(Req),
    true = is_binary(Data),
    A = packer:unpack(Data),
    B = doit(A),
    D = packer:pack(B),
    Headers = [{<<"content-type">>, <<"application/octet-stream">>},
    {<<"Access-Control-Allow-Origin">>, <<"*">>}],
    {ok, Req4} = cowboy_req:reply(200, Headers, D, Req3),
    {ok, Req4, State}.
init(_Type, Req, _Opts) -> {ok, Req, no_state}.
terminate(_Reason, _Req, _State) -> ok.
-define(WORD, 10000000).%10 megabytes.
doit({Y, Days}) -> 
    true = is_integer(Days),
    X = list_to_binary(inheritance:doit(atom_to_list(Y), Days)),
    {ok, X};
doit(X) ->
    io:fwrite("I can't handle this \n"),
    io:fwrite(packer:pack(X)), %unlock2
    {error}.
hex2bin([A|[B|C]], Acc) ->
    X = hex2int(A),
    Y = hex2int(B),
    Z = (X*16) + Y,
    hex2bin(C, <<Acc/binary, Z>>);
    
hex2bin([], A) -> A.
hex2int(X) when ((X > 47) and (X < 58)) ->
    X - 48;
hex2int(X) when ((X > 96) and (X < 103)) ->
    X - 86;
hex2int(X) when ((X > 64) and (X < 71)) ->
    X - 54.
 

    
