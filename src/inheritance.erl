-module(inheritance).
-export([time_now/0, doit/2, test/0]).
doit(Tx, Days) ->
    Seconds = Days * 86400,
    set_stamp(Tx, Seconds + time_now()).
time_now() ->
    {A, B, _} = os:timestamp(),
    (A*1000000)+B.
set_stamp(X, Date) ->
    Y = remove_last_4_bytes(X),
    Y ++ binary2hex(<<Date:32>>).
binary2hex(<<>>) -> [];
binary2hex(<<X, Y/binary>>) -> 
    B = X rem 16,
    A = X div 16,
    [nib2letter(A)|[nib2letter(B)|binary2hex(Y)]].
remove_last_4_bytes(X) when length(X) == 4 ->
    [];
remove_last_4_bytes([X|T]) ->
    [X|remove_last_4_bytes(T)].
nib2letter(X) when (X>(-1)) and (X<10) ->
    X+48;
nib2letter(X) when (X>9) and (X<16) ->
    X+87.


%    <<Y/binary, Date:32>>.
%remove_last_4_bytes(<<_:32>>) -> 
%    <<>>;
%remove_last_4_bytes(<<X, Y/binary>>) -> 
%    Z = remove_last_4_bytes(Y),
%    <<X, Z/binary>>.
test() ->
    true = time_now() < math:pow(256, 4), 
    success.
    
