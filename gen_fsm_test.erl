%%----------------------------------------------------
%%%%% 有限状态机 
%%%%% @author hebishi@shiyuegmail.com
%%%%%----------------------------------------------------
-module(gen_fsm_test).
-behaviour(gen_fsm).

-export([start_link/0]).
-export([ lockevent/1
        , do_unlock/0
        , do_lock/0
        , open/2
        , locked/3]).

-export([ init/1
        , handle_event/3
        , handle_sync_event/4
        , handle_info/3
        , terminate/3
        , code_change/4]).

%% 记录锁的状态
-record(lock_state,{state}).


%% 宏定义timeout为40秒
-define(TIMEOUT,40000). 


%% 开启服务器
start_link() ->
    gen_fsm:start_link({local, ?MODULE}, ?MODULE, [], []).

%% 初始化锁为锁住状态
init([]) ->
    process_flag(trap_exit, true),
    State = #lock_state{state = lock},
    {ok, locked,State}.

%% 锁事件
lockevent(Digit) ->
    gen_fsm:send_event(?MODULE,{lockevent,Digit}).

%% 解锁
do_unlock() ->
    io:format("开始解锁~n").
    

%% 锁住
do_lock() ->
    io:format("锁住~n").


%% 在锁住的事件状态下，接收客户端发来的事件 
locked({button, Digit}, {SoFar, Code},State) ->
    case [Digit|SoFar] of
        Code ->
            do_unlock(),
            UnLockState = #lock_state{state = unlock},
            {next_state, open, {[], Code},UnLockState, ?TIMEOUT};
        Incomplete when length(Incomplete)<length(Code) ->
            LockState = #lock_state{state = lock},
            {next_state, locked, {Incomplete, Code},LockState};
        _Wrong ->
            {next_state, locked, {[], Code},State}
    end.

%% 打开锁
open(timeout,State) ->
    do_lock(),
    {next_state,locked,State}.


%% 处理异步消息的回调函数
handle_event(_Event, StateName, State) ->
    {next_state, StateName, State}.

%% 处理同步消息的回调函数
handle_sync_event(_Event, _From, StateName, State) ->
    {reply, ok, StateName, State}.

%% 处理其他消息的回调函数
handle_info(_Info, StateName, State) ->
    {next_state, StateName, State}.

%% 停止, 
terminate(_Reason, _StateName, _State) ->
    %% 在退出之前,这里处理所要清理的
    ok.

%% 执行代码升级/降级操作的回调函数 
code_change(_OldVsn, StateName, State, _Extra) ->
    {ok, StateName, State}.

