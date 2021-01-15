%%%-------------------------------------------------------------------
%%% @author yr
%%% @copyright (C) 2021, <yanFan>
%%% @doc
%%%
%%% @end
%%% Created : 11. 1月 2021 18:34
%%%-------------------------------------------------------------------
-module(g_return_cli).
-author("yr").

-include("aoyin_common.hrl").

%% API
-export([grpc_get_money/2]).

grpc_get_money(Account, Platform) ->
%%    Arg = #{account => <<"P3Y68S7E680K">>, platform => <<"demo">>},
    Arg = #{account => Account, platform => Platform},
    case ?assert_grpc(return_return_client, get_money, Arg, #{channel => ?default_channel}) of
        {ok, #{money := Money}, _} ->
            Money;
        _ ->
            0
    end.