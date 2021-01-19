%%%-------------------------------------------------------------------
%% @doc Behaviour to implement for grpc service grpc.return.v1.Return.
%% @end
%%%-------------------------------------------------------------------

%% this module was generated on 2021-01-19T08:21:10+00:00 and should not be modified manually

-module(grpc_return_bhvr).

%% @doc Unary RPC
-callback get_money(ctx:ctx(), ct_return_pb:account_plat()) ->
    {ok, ct_return_pb:charge(), ctx:ctx()} | grpcbox_stream:grpc_error_response().

