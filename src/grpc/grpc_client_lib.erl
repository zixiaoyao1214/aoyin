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
    apply(M, F, A, #{channel => ?default_channel}).

apply(M, F, A, Opts) ->
    Channel = maps:get(channel, Opts, ?default_channel),
    case ets:lookup(aoyin_client_info, Channel) of
        [_] ->
            M:F(A, Opts);
        _ ->
            {error,econnrefused}
    end.