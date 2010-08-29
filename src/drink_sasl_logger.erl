%%%-------------------------------------------------------------------
%%% File    : drink_sasl_logger.erl
%%% Author  : Dan Willemsen <dan@csh.rit.edu>
%%% Purpose : 
%%%
%%%
%%% edrink, Copyright (C) 2010 Dan Willemsen
%%%
%%% This program is free software; you can redistribute it and/or
%%% modify it under the terms of the GNU General Public License as
%%% published by the Free Software Foundation; either version 2 of the
%%% License, or (at your option) any later version.
%%%
%%% This program is distributed in the hope that it will be useful,
%%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%%% General Public License for more details.
%%%                         
%%% You should have received a copy of the GNU General Public License
%%% along with this program; if not, write to the Free Software
%%% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
%%% 02111-1307 USA
%%%
%%%-------------------------------------------------------------------

-module (drink_sasl_logger).
-behaviour (gen_server).

-export ([start_link/0]).
-export ([init/1, terminate/2, code_change/3]).
-export ([handle_call/3, handle_cast/2, handle_info/2]).

-record (state, {}).

start_link () ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init ([]) ->
    dw_events:register_pid(drink, {registered, ?MODULE}),
    {ok, #state{}}.

terminate (_Reason, _State) ->
    dw_events:unregister_pid(drink),
    ok.

code_change (_OldVsn, State, _Extra) ->
    {ok, State}.

handle_cast (_Request, State) -> {noreply, State}.

handle_call (_Request, _From, State) -> {noreply, State}.

handle_info ({dw_event, drink, Pid, Event}, State) ->
    error_logger:error_msg("drink(~p): ~p~n", [Pid, Event]),
    {noreply, State};
handle_info (_Info, State) -> {noreply, State}.

