-ifndef(FRPC_SERVICE_CHANNEL_H_).
-define(FRPC_SERVICE_CHANNEL_H_, 1).

-define(default_channel, default_channel).

-define(assert_grpc(M, F, A), grpc_client_lib:apply(M, F, A)).
-define(assert_grpc(M, F, A, Opts), grpc_client_lib:apply(M, F, A, Opts)).

-endif.