%%%-------------------------------------------------------------------
%%% @author yr
%%% @copyright (C) 2021, <yanFan>
%%% @doc
%%%
%%% @end
%%% Created : 12. 1月 2021 9:13
%%%-------------------------------------------------------------------
-module(grpc_client_lib).
-author("yr").

-include("aoyin_common.hrl").
%% API
-export([
    apply/3
    , apply/4
]).

apply(M, F, A) ->
    apply(M, F, A, #{timeout => ?default_timeout, channel => ?default_channel}).

apply(M, F, A, Opts) ->
    try
        M:F(A, Opts)
    catch
        _ -> error
    end.