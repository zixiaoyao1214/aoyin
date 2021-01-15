%%%-------------------------------------------------------------------
%% @doc Behaviour to implement for grpc service return.Return.
%% @end
%%%-------------------------------------------------------------------

%% this module was generated and should not be modified manually

-module(return_return_bhvr).

-callback get_money(ct_return_pb:account_plat(), grpc:metadata())
    -> {ok, ct_return_pb:charge(), grpc:metadata()}
     | {error, grpc_stream:error_response()}.

