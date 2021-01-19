%%%-------------------------------------------------------------------
%% @doc Client module for grpc service grpc.return.v1.Return.
%% @end
%%%-------------------------------------------------------------------

%% this module was generated on 2021-01-19T08:21:10+00:00 and should not be modified manually

-module(grpc_return_client).

-compile(export_all).
-compile(nowarn_export_all).

-include_lib("grpcbox/include/grpcbox.hrl").

-define(is_ctx(Ctx), is_tuple(Ctx) andalso element(1, Ctx) =:= ctx).

-define(SERVICE, 'grpc.return.v1.Return').
-define(PROTO_MODULE, 'ct_return_pb').
-define(MARSHAL_FUN(T), fun(I) -> ?PROTO_MODULE:encode_msg(I, T) end).
-define(UNMARSHAL_FUN(T), fun(I) -> ?PROTO_MODULE:decode_msg(I, T) end).
-define(DEF(Input, Output, MessageType), #grpcbox_def{service=?SERVICE,
                                                      message_type=MessageType,
                                                      marshal_fun=?MARSHAL_FUN(Input),
                                                      unmarshal_fun=?UNMARSHAL_FUN(Output)}).

%% @doc Unary RPC
-spec get_money(ct_return_pb:account_plat()) ->
    {ok, ct_return_pb:charge(), grpcbox:metadata()} | grpcbox_stream:grpc_error_response().
get_money(Input) ->
    get_money(ctx:new(), Input, #{}).

-spec get_money(ctx:t() | ct_return_pb:account_plat(), ct_return_pb:account_plat() | grpcbox_client:options()) ->
    {ok, ct_return_pb:charge(), grpcbox:metadata()} | grpcbox_stream:grpc_error_response().
get_money(Ctx, Input) when ?is_ctx(Ctx) ->
    get_money(Ctx, Input, #{});
get_money(Input, Options) ->
    get_money(ctx:new(), Input, Options).

-spec get_money(ctx:t(), ct_return_pb:account_plat(), grpcbox_client:options()) ->
    {ok, ct_return_pb:charge(), grpcbox:metadata()} | grpcbox_stream:grpc_error_response().
get_money(Ctx, Input, Options) ->
    grpcbox_client:unary(Ctx, <<"/grpc.return.v1.Return/GetMoney">>, Input, ?DEF(account_plat, charge, <<"grpc.return.v1.AccountPlat">>), Options).

