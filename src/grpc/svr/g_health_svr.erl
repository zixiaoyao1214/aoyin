%%%-------------------------------------------------------------------
%%% @author yr
%%% @copyright (C) 2021, <yanFan>
%%% @doc
%%%
%%% @end
%%% Created : 19. 1月 2021 19:22
%%%-------------------------------------------------------------------
-module(g_health_svr).
-author("yr").

-behavior(grpcbox_health_bhvr).

-export([check/2,
    watch/2]).

%% @doc Unary RPC
-callback check(ctx:ctx(), grpcbox_health_pb:health_check_request()) ->
    {ok, grpcbox_health_pb:health_check_response(), ctx:ctx()} | grpcbox_stream:grpc_error_response().
check(Ctx, #{service := <<>>}) ->
    {ok, #{status => 'SERVING'}, Ctx};
check(Ctx, #{service := _Service}) ->
    %% TODO: lookup if we are serving this service
    {ok, #{status => 'UNKNOWN'}, Ctx}.


%% @doc
-callback watch(grpcbox_health_pb:health_check_request(), grpcbox_stream:t()) ->
    ok | grpcbox_stream:grpc_error_response().
watch(_Request, _Stream) ->
    ok.
