%%%-------------------------------------------------------------------
%% @doc misc public API
%% @end
%%%-------------------------------------------------------------------

-module(aoyin_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    aoyin_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
