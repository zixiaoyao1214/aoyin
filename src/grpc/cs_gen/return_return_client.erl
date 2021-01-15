%%%-------------------------------------------------------------------
%% @doc Client module for grpc service return.Return.
%% @end
%%%-------------------------------------------------------------------

%% this module was generated and should not be modified manually

-module(return_return_client).

-compile(export_all).
-compile(nowarn_export_all).

-include_lib("grpc/include/grpc.hrl").

-define(SERVICE, 'return.Return').
-define(PROTO_MODULE, 'ct_return_pb').
-define(MARSHAL(T), fun(I) -> ?PROTO_MODULE:encode_msg(I, T) end).
-define(UNMARSHAL(T), fun(I) -> ?PROTO_MODULE:decode_msg(I, T) end).
-define(DEF(Path, Req, Resp, MessageType),
        #{path => Path,
          service =>?SERVICE,
          message_type => MessageType,
          marshal => ?MARSHAL(Req),
          unmarshal => ?UNMARSHAL(Resp)}).

-spec get_money(ct_return_pb:account_plat())
    -> {ok, ct_return_pb:charge(), grpc:metadata()}
     | {error, term()}.
get_money(Req) ->
    get_money(Req, #{}, #{}).

-spec get_money(ct_return_pb:account_plat(), grpc:options())
    -> {ok, ct_return_pb:charge(), grpc:metadata()}
     | {error, term()}.
get_money(Req, Options) ->
    get_money(Req, #{}, Options).

-spec get_money(ct_return_pb:account_plat(), grpc:metadata(), grpc_client:options())
    -> {ok, ct_return_pb:charge(), grpc:metadata()}
     | {error, term()}.
get_money(Req, Metadata, Options) ->
    grpc_client:unary(?DEF(<<"/return.Return/GetMoney">>,
                           account_plat, charge, <<"return.AccountPlat">>),
                      Req, Metadata, Options).

