%%%-------------------------------------------------------------------
%% @doc misc top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(aoyin_sup).

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).
-define(SUP, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%% sup_flags() = #{strategy => strategy(),         % optional
%%                 intensity => non_neg_integer(), % optional
%%                 period => pos_integer()}        % optional
%% child_spec() = #{id => child_id(),       % mandatory
%%                  start => mfargs(),      % mandatory
%%                  restart => restart(),   % optional
%%                  shutdown => shutdown(), % optional
%%                  type => worker(),       % optional
%%                  modules => modules()}   % optional
init([]) ->
    MaxRestarts = 5,
    MaxSecondsBetweenRestarts = 10,
    SupFlags = #{strategy => one_for_one,
        intensity => MaxRestarts,
        period => MaxSecondsBetweenRestarts},

    Child = #{id => 'aoyin_mgr',
        start => {'aoyin_mgr', start_link, []},
        restart => transient,
        shutdown => infinity,
        type => supervisor,
        modules => ['aoyin_mgr']
    },
    {ok, {SupFlags, [Child]}}.
