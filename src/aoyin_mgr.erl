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