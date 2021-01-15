%%%-------------------------------------------------------------------
%%% @author yr
%%% @copyright (C) 2021, <yanFan>
%%% @doc
%%% @end
%%%-------------------------------------------------------------------
-module(aoyin_mgr).

-behaviour(gen_server).

-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2,
    code_change/3]).

-define(SERVER, ?MODULE).

-record(aoyin_mgr_state, {}).

%%%===================================================================
%%% Spawning and gen_server implementation
%%%===================================================================

start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

init([]) ->
    register(),
    {ok, #aoyin_mgr_state{}}.

handle_call(_Request, _From, State = #aoyin_mgr_state{}) ->
    {reply, ok, State}.

handle_cast(_Request, State = #aoyin_mgr_state{}) ->
    {noreply, State}.

handle_info(_Info, State = #aoyin_mgr_state{}) ->
    {noreply, State}.

terminate(_Reason, _State = #aoyin_mgr_state{}) ->
    ok.

code_change(_OldVsn, State = #aoyin_mgr_state{}, _Extra) ->
    {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================

%% client and server register
register() ->
    Servers = application:get_env(aoyin, servers, []),
    maybe_start_server(Servers),
    Clients = application:get_env(aoyin, clients, []),
    maybe_start_client(Clients).

maybe_start_client([]) ->
    ok;
maybe_start_client([#{channel := Channel, url := URL, opts := Opts} | Tail]) ->
    grpc_client_sup:create_channel_pool(Channel, URL, Opts),
    maybe_start_client(Tail).

maybe_start_server([]) ->
    ok;
maybe_start_server([#{name := Name, port := Port, services := Services, opts := Opts} | Tail]) ->
    case grpc:start_server(Name, Port, Services, Opts) of
        {ok, _} -> ok;
        {error, {already_started, _}} ->
            grpc:stop_server(Name),
            grpc:start_server(Name, Port, Services, Opts);
        {error, ERR} ->
            io:format("aoyin service ~p start fail : ~p", [Name, ERR])
    end,
    maybe_start_server(Tail).