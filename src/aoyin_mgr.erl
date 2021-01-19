%%%-------------------------------------------------------------------
%%% @author yr
%%% @copyright (C) 2021, <yanFan>
%%% @doc
%%% @end
%%%-------------------------------------------------------------------
-module(aoyin_mgr).

-behaviour(gen_server).

-export([
    start_link/0
    , monitor/2
]).

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
    ets:new(aoyin_client_info, [named_table, set, public, {read_concurrency, true}]),
    monitor(),
    {ok, #aoyin_mgr_state{}}.

handle_call(_Request, _From, State = #aoyin_mgr_state{}) ->
    {reply, ok, State}.

handle_cast(_Request, State = #aoyin_mgr_state{}) ->
    {noreply, State}.

handle_info({monitor, Name}, State = #aoyin_mgr_state{}) ->
    spawn(?MODULE, monitor, [Name, self()]),
    {noreply, State};
handle_info(_Info, State = #aoyin_mgr_state{}) ->
    {noreply, State}.

terminate(_Reason, _State = #aoyin_mgr_state{}) ->
    ok.

code_change(_OldVsn, State = #aoyin_mgr_state{}, _Extra) ->
    {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================

monitor() ->
    case application:get_env(grpcbox, client) of
        {ok, #{channels := Channels}} ->
            [spawn(?MODULE, monitor, [Name, self()])
                || {Name, _Endpoints, _Options} <- Channels];
        _ ->
            ok
    end.

monitor(Name, PID) when is_pid(PID) ->
    case grpcbox_health_client:check(#{service => <<>>}, #{channel => Name}) of
        {ok, #{status := 'SERVING'}, _} ->
            ets:insert(aoyin_client_info, {Name});
        _ ->
            ets:delete(aoyin_client_info, Name)
    end,
    erlang:send_after(5000, PID, {monitor, Name}).